#!/bin/sh

echo "=================================================="
echo "[TXW81X pre_build.sh] RUNNING - inspect jpeg/rtp"
echo "PWD=$(pwd)"
echo "=================================================="

CFG="sdk/OpenTXW81X/project/project_config.h"

if [ ! -f "$CFG" ]; then
  echo "[TXW81X pre_build.sh] ERROR: $CFG not found"
  exit 1
fi

echo "[TXW81X pre_build.sh] current buffers:"
grep -E "CUSTOM_SIZE|JPG0_BUF_LEN|JPG0_NODE|JPG1_BUF_LEN|JPG1_NODE" "$CFG" || true

echo "[TXW81X pre_build.sh] wifi defines:"
grep -E "WIFI_RTS_THRESHOLD|WIFI_RTS_MAX_RETRY|WIFI_TX_MAX_RETRY|WIFI_TX_MAX_POWER" "$CFG" || true

echo "[TXW81X pre_build.sh] jpeg/rtp defines:"
grep -R "TARGET_JPG_LEN\|QUALITY_CTRL_\|DQT_DEF\|DQT_MAX_INDEX\|MAX_DATA_PACKET_SIZE\|send_rtp_packet_more" \
  sdk/OpenTXW81X 2>/dev/null || true

echo "[TXW81X pre_build.sh] DONE"
