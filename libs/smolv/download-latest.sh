#!/bin/bash
cd "$(dirname "$0")"
curl "https://raw.githubusercontent.com/aras-p/smol-v/refs/heads/main/source/smolv.cpp" >> smolv.cpp
curl "https://raw.githubusercontent.com/aras-p/smol-v/refs/heads/main/source/smolv.h" >> smolv.h
