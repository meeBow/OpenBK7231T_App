#!/bin/sh

echo "=================================================="
echo "[TXW81X pre_build.sh] RUNNING - no buffer patch"
echo "PWD=$(pwd)"
echo "=================================================="

CFG="sdk/OpenTXW81X/project/project_config.h"

if [ ! -f "$CFG" ]; then
  echo "[TXW81X pre_build.sh] ERROR: $CFG not found"
  exit 1
fi

echo "[TXW81X pre_build.sh] current:"
grep -E "CUSTOM_SIZE|JPG0_BUF_LEN|JPG0_NODE|JPG1_BUF_LEN|JPG1_NODE" "$CFG" || true

echo "[TXW81X pre_build.sh] DONE"
