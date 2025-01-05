#!/bin/bash
cd "$(dirname "$0")"
'/home/maddie/Downloads/slang-2024.17-linux-x86_64/bin/slangc' -emit-spirv-directly -g2 -fvk-use-entrypoint-name triangle.slang -target spirv -o triangle.spv