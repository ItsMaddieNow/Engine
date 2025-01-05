cmake_minimum_required(VERSION 3.5.0)
project(Engine VERSION 0.1.0 LANGUAGES C CXX)
configure_file(src/Version.h.in src/Version.h)

add_executable(Engine src/main.cpp)

find_package(glfw3 3.3 REQUIRED)
find_package(Threads REQUIRED)
find_package(Vulkan REQUIRED)
find_package(X11 REQUIRED)

include_directories(${PROJECT_BINARY_DIR})
target_include_directories(Engine PUBLIC "${PROJECT_BINARY_DIR}")
target_link_libraries(Engine glfw Vulkan::Vulkan dl Threads::Threads X11)

