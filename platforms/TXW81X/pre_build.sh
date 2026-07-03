#!/bin/sh

echo "=================================================="
echo "[TXW81X pre_build.sh] RUNNING"
echo "PWD=$(pwd)"
echo "=================================================="

CFG="sdk/OpenTXW81X/project/project_config.h"

if [ ! -f "$CFG" ]; then
  echo "[TXW81X pre_build.sh] ERROR: $CFG not found"
  exit 1
fi

echo "[TXW81X pre_build.sh] before:"
grep -E "CUSTOM_SIZE|JPG0_BUF_LEN|JPG0_NODE|JPG1_BUF_LEN|JPG1_NODE" "$CFG" || true

sed -i 's/#define CUSTOM_SIZE (60\*1024)/#define CUSTOM_SIZE (120*1024)/' "$CFG"
sed -i 's/#define JPG0_NODE 40/#define JPG0_NODE 80/' "$CFG"
sed -i 's/#define JPG1_NODE 40/#define JPG1_NODE 80/' "$CFG"

echo "[TXW81X pre_build.sh] after:"
grep -E "CUSTOM_SIZE|JPG0_BUF_LEN|JPG0_NODE|JPG1_BUF_LEN|JPG1_NODE" "$CFG" || true

echo "[TXW81X pre_build.sh] DONE"
