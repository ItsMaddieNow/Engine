project('engine', 'cpp')

conf_data = configuration_data()
conf_data.set('engine_version_str', '0.1.0')
conf_data.set('engine_version_major', 0)
conf_data.set('engine_version_minor', 1)
conf_data.set('engine_version_patch', 0)
configure_file(input : 'src/Version.h.in',
               output : 'Version.h',
               configuration : conf_data)
vulkan = dependency('vulkan')
glm = dependency('glm')
glfw = dependency('glfw3')

executable('engine', 'src/main.cpp',
           dependencies : [vulkan, glfw, glm],
           install : true,
           install_dir : 'bin'
           )


slang_shaders = ['src/shaders/triangle.slang']
output_shaders = []

slangc = find_program('slangc')
smolv = find_program('smolv')
zstd = find_program('zstd')

foreach s : slang_shaders
    spirv_shader = custom_target(
        'spirv shader @0@'.format(s.split('/')[-1]),
        command: [slangc, '-emit-spirv-directly', '-g2', '-fvk-use-entrypoint-name', '@INPUT@', '-o', '@OUTPUT@', '-target', 'spirv'],
        input : s, 
        output : '@BASENAME@.spv',
        install : get_option('debug')==false,
        install_dir : 'bin/shaders'
    )
    if get_option('debug')
        smolv_shader = custom_target(
            'smolv shader @0@'.format(s.split('/')[-1]),
            command : [smolv, '-o', '@OUTPUT@', '--', '@INPUT@'],
            input : spirv_shader, 
            output : '@BASENAME@.smlv',
            depends : [spirv_shader]
        )
        zstd_shader = custom_target(
            'zstd shader @0@'.format(s.split('/')[-1]),
            command : [zstd, '@INPUT@', '-o', '@OUTPUT@'],
            input : smolv_shader, 
            output : '@BASENAME@.smlv.zstd',
            depends : [smolv_shader],
            install : true,
            install_dir : 'bin/shaders'
        )
        output_shaders += zstd_shader
    else 
        output_shaders += spirv_shader
    endif
endforeach