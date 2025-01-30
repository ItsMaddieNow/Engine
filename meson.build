project('engine', 'cpp',
    version: '0.1.0')

conf_data = configuration_data()
conf_data.set('engine_version_str', '0.1.0')
conf_data.set('engine_version_major', 0)
conf_data.set('engine_version_minor', 1)
conf_data.set('engine_version_patch', 0)
configure_file(input : 'src/Version.h.in',
               output : 'Version.h',
               configuration : conf_data)

message(get_option('prefix'))
shader_dir = get_option('prefix') / get_option('datadir') / meson.project_name() / 'shaders'
bin_dir = get_option('prefix') / get_option('bindir')
add_global_arguments('-DSHADER_DIR="@0@"'.format(shader_dir), language: 'cpp')
if get_option('debug')
    add_global_arguments('-DDEBUG=1', language: 'cpp')
endif

vulkan = dependency('vulkan')
glm = dependency('glm')
glfw = dependency('glfw3')
zstd = dependency('libzstd')
threads = dependency('threads')

smolv = static_library('smolv', ['libs/smolv/smolv.h', 'libs/smolv/smolv.cpp'])

executable('engine', 'src/main.cpp',
           dependencies : [vulkan, glfw, glm, zstd, threads],
           link_with : [smolv],
           install : true,
           install_dir : bin_dir
           )

slang_shaders = ['src/shaders/triangle.slang']
output_shaders = []

slangc_bin = find_program('slangc')
smolv_bin = find_program('smolv')
zstd_bin = find_program('zstd')

message(get_option('debug'))
message(bin_dir)
message(shader_dir)
foreach s : slang_shaders
    spirv_shader = custom_target(
        'spirv shader @0@'.format(s.split('/')[-1]),
        command: [slangc_bin, '-emit-spirv-directly', get_option('debug')?'-g3':'-g0', '-fvk-use-entrypoint-name', '@INPUT@', '-o', '@OUTPUT@', '-target', 'spirv'],
        input : s, 
        output : '@BASENAME@.spv',
        install: get_option('debug'),
        install_dir: shader_dir
    )
    if get_option('debug')==false
        smolv_shader = custom_target(
            'smolv shader @0@'.format(s.split('/')[-1]),
            command : [smolv_bin, '-o', '@OUTPUT@', '--', '@INPUT@'],
            input : spirv_shader, 
            output : '@BASENAME@.smlv',
            depends : [spirv_shader]
        )
        zstd_shader = custom_target(
            'zstd shader @0@'.format(s.split('/')[-1]),
            command : [zstd_bin, '--force', '@INPUT@', '-o', '@OUTPUT@'],
            input : smolv_shader, 
            output : '@BASENAME@.smlv.zstd',
            depends : [smolv_shader],
            install : true,
            install_dir: shader_dir
        )
        output_shaders += zstd_shader
    else 
        output_shaders += spirv_shader
    endif
endforeach
