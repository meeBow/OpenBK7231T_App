#!/bin/sh

echo "=================================================="
echo "[TXW81X pre_build.sh] RUNNING - jpeg quality patch"
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

echo "[TXW81X pre_build.sh] wifi defines:"
grep -E "WIFI_RTS_THRESHOLD|WIFI_RTS_MAX_RETRY|WIFI_TX_MAX_RETRY|WIFI_TX_MAX_POWER" "$CFG" || true

echo "[TXW81X pre_build.sh] jpeg quality before:"
grep -R -n -E "DQT_DEF|DQT_MAX_INDEX|TARGET_JPG_LEN|QUALITY_CTRL_" \
  "$JPG_H" \
  "$JPG_V2" \
  2>/dev/null || true

sed -i -E 's|#define[[:space:]]+TARGET_JPG_LEN[[:space:]]+[0-9]+|#define TARGET_JPG_LEN     25000|' \
  "$JPG_H"

echo "[TXW81X pre_build.sh] jpeg quality after:"
grep -R -n -E "DQT_DEF|DQT_MAX_INDEX|TARGET_JPG_LEN|QUALITY_CTRL_" \
  "$JPG_H" \
  "$JPG_V2" \
  2>/dev/null || true

echo "[TXW81X pre_build.sh] DONE"
