#!/usr/bin/env bash
set -e

CFG="sdk/OpenTXW81X/project/project_config.h"

echo "[TXW81X prebuild] patching camera buffer settings"

sed -i 's/#define CUSTOM_SIZE (60\*1024)/#define CUSTOM_SIZE (120*1024)/' "$CFG"

sed -i 's/#define JPG0_NODE 40/#define JPG0_NODE 80/' "$CFG"
sed -i 's/#define JPG1_NODE 40/#define JPG1_NODE 80/' "$CFG"

grep -E "CUSTOM_SIZE|JPG0_BUF_LEN|JPG0_NODE|JPG1_BUF_LEN|JPG1_NODE" "$CFG"
