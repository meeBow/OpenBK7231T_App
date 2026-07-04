#!/bin/sh

echo "=================================================="
echo "[TXW81X pre_build.sh] RUNNING - force sensor GC0329"
echo "PWD=$(pwd)"
echo "=================================================="

CFG="sdk/OpenTXW81X/project/project_config.h"

if [ ! -f "$CFG" ]; then
  echo "[TXW81X pre_build.sh] ERROR: $CFG not found"
  exit 1
fi

echo "[TXW81X pre_build.sh] sensor before:"
grep -E "CMOS_AUTO_LOAD|DEV_SENSOR_" "$CFG" || true

sed -i -E 's|#define[[:space:]]+CMOS_AUTO_LOAD[[:space:]]+[0-9]+|#define CMOS_AUTO_LOAD 0|' "$CFG"

sed -i -E 's|#define[[:space:]]+DEV_SENSOR_GC0329[[:space:]]+[0-9]+|#define DEV_SENSOR_GC0329 0|' "$CFG"
sed -i -E 's|#define[[:space:]]+DEV_SENSOR_SP0A19[[:space:]]+[0-9]+|#define DEV_SENSOR_SP0A19 0|' "$CFG"
sed -i -E 's|#define[[:space:]]+DEV_SENSOR_BF3A03[[:space:]]+[0-9]+|#define DEV_SENSOR_BF3A03 0|' "$CFG"
sed -i -E 's|#define[[:space:]]+DEV_SENSOR_SP0828[[:space:]]+[0-9]+|#define DEV_SENSOR_SP0828 1|' "$CFG"
sed -i -E 's|#define[[:space:]]+DEV_SENSOR_SP0A20[[:space:]]+[0-9]+|#define DEV_SENSOR_SP0A20 0|' "$CFG"

echo "[TXW81X pre_build.sh] sensor after:"
grep -E "CMOS_AUTO_LOAD|DEV_SENSOR_" "$CFG" || true

echo "[TXW81X pre_build.sh] DONE"
