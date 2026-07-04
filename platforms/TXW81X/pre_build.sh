#!/bin/sh

echo "=================================================="
echo "[TXW81X pre_build.sh] RUNNING - jpeg quality patch dqt4"
echo "PWD=$(pwd)"
echo "=================================================="

CFG="sdk/OpenTXW81X/project/project_config.h"
JPG_H="sdk/OpenTXW81X/sdk/include/lib/video/dvp/jpeg/jpg.h"
JPG_V2="sdk/OpenTXW81X/sdk/lib/video/dvp/jpeg/jpg_v2.c"

if [ ! -f "$CFG" ]; then
  echo "[TXW81X pre_build.sh] ERROR: $CFG not found"
  exit 1
fi

if [ ! -f "$JPG_H" ]; then
  echo "[TXW81X pre_build.sh] ERROR: $JPG_H not found"
  exit 1
fi

echo "[TXW81X pre_build.sh] current buffers:"
grep -E "CUSTOM_SIZE|JPG0_BUF_LEN|JPG0_NODE|JPG1_BUF_LEN|JPG1_NODE" "$CFG" || true

echo "[TXW81X pre_build.sh] jpeg quality before:"
grep -R -n -E "DQT_DEF|DQT_MAX_INDEX|TARGET_JPG_LEN|QUALITY_CTRL_" \
  "$JPG_H" \
  "$JPG_V2" \
  2>/dev/null || true

sed -i -E 's|#define[[:space:]]+DQT_DEF[[:space:]]+[0-9]+|#define DQT_DEF            4|' \
  "$JPG_H"

sed -i -E 's|#define[[:space:]]+TARGET_JPG_LEN[[:space:]]+[0-9]+|#define TARGET_JPG_LEN     30000|' \
  "$JPG_H"

echo "[TXW81X pre_build.sh] jpeg quality after:"
grep -R -n -E "DQT_DEF|DQT_MAX_INDEX|TARGET_JPG_LEN|QUALITY_CTRL_" \
  "$JPG_H" \
  "$JPG_V2" \
  2>/dev/null || true

echo "[TXW81X pre_build.sh] DONE"
