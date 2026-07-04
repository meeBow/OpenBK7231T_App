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

echo "[TXW81X pre_build.sh] wifi before:"
grep -E "WIFI_RTS_THRESHOLD|WIFI_RTS_MAX_RETRY|WIFI_TX_MAX_RETRY|WIFI_TX_MAX_POWER" "$CFG" || true

sed -i -E 's|#define[[:space:]]+WIFI_RTS_THRESHOLD[[:space:]]+[0-9]+|#define WIFI_RTS_THRESHOLD 512|' "$CFG"
sed -i -E 's|#define[[:space:]]+WIFI_RTS_MAX_RETRY[[:space:]]+[0-9]+|#define WIFI_RTS_MAX_RETRY 8|' "$CFG"
sed -i -E 's|#define[[:space:]]+WIFI_TX_MAX_RETRY[[:space:]]+[0-9]+|#define WIFI_TX_MAX_RETRY 15|' "$CFG"

echo "[TXW81X pre_build.sh] wifi after:"
grep -E "WIFI_RTS_THRESHOLD|WIFI_RTS_MAX_RETRY|WIFI_TX_MAX_RETRY|WIFI_TX_MAX_POWER" "$CFG" || true

echo "[TXW81X pre_build.sh] DONE"
