#!/bin/sh

echo "=================================================="
echo "[TXW81X pre_build.sh] RUNNING - extreme jpeg quality patch"
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

if [ ! -f "$JPG_V2" ]; then
  echo "[TXW81X pre_build.sh] ERROR: $JPG_V2 not found"
  exit 1
fi

echo "[TXW81X pre_build.sh] current buffers:"
grep -E "CUSTOM_SIZE|JPG0_BUF_LEN|JPG0_NODE|JPG1_BUF_LEN|JPG1_NODE" "$CFG" || true

echo "[TXW81X pre_build.sh] jpeg quality before:"
grep -R -n -E "DQT_DEF|DQT_MAX_INDEX|TARGET_JPG_LEN|QUALITY_CTRL_|g_dqtable_index|pdqt_tab" \
  "$JPG_H" \
  "$JPG_V2" \
  2>/dev/null || true

# JPEG quality: very aggressive / high quality side
sed -i -E 's|#define[[:space:]]+DQT_DEF[[:space:]]+[0-9]+|#define DQT_DEF            0|' \
  "$JPG_H"

sed -i -E 's|#define[[:space:]]+TARGET_JPG_LEN[[:space:]]+[0-9]+|#define TARGET_JPG_LEN     60000|' \
  "$JPG_H"

# Disable/neutralize automatic quality PID as much as possible
sed -i -E 's|#define[[:space:]]+QUALITY_CTRL_P[[:space:]]+[0-9]+|#define QUALITY_CTRL_P     0|' \
  "$JPG_H"

sed -i -E 's|#define[[:space:]]+QUALITY_CTRL_I[[:space:]]+[0-9]+|#define QUALITY_CTRL_I     0|' \
  "$JPG_H"

sed -i -E 's|#define[[:space:]]+QUALITY_CTRL_D[[:space:]]+[0-9]+|#define QUALITY_CTRL_D     0|' \
  "$JPG_H"

# Force initial DQT table index to 0
sed -i -E 's|volatile[[:space:]]+int8_t[[:space:]]+g_dqtable_index[[:space:]]*=[[:space:]]*DQT_DEF|volatile int8_t g_dqtable_index = 0|' \
  "$JPG_V2"

sed -i -E 's|static[[:space:]]+int8[[:space:]]+pdqt_tab[[:space:]]*=[[:space:]]*DQT_DEF|static int8 pdqt_tab = 0|' \
  "$JPG_V2"

echo "[TXW81X pre_build.sh] jpeg quality after:"
grep -R -n -E "DQT_DEF|DQT_MAX_INDEX|TARGET_JPG_LEN|QUALITY_CTRL_|g_dqtable_index|pdqt_tab" \
  "$JPG_H" \
  "$JPG_V2" \
  2>/dev/null || true

echo "[TXW81X pre_build.sh] DONE"
