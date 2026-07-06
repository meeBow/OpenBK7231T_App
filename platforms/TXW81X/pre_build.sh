#!/bin/sh

echo "=================================================="
echo "[TXW81X pre_build.sh] RUNNING - inspect yuv image format"
echo "PWD=$(pwd)"
echo "=================================================="

CFG="sdk/OpenTXW81X/project/project_config.h"
CSI_V2="sdk/OpenTXW81X/sdk/lib/video/dvp/cmos_sensor/csi_v2.c"

if [ ! -f "$CFG" ]; then
  echo "[TXW81X pre_build.sh] ERROR: $CFG not found"
  exit 1
fi

if [ ! -f "$CSI_V2" ]; then
  echo "[TXW81X pre_build.sh] ERROR: $CSI_V2 not found"
  exit 1
fi

echo "[TXW81X pre_build.sh] project format defines:"
grep -n -E "IMAGE_FORMAT|YUV_MODE|SCALE_WIDTH_TO_JPEG|SCALE_HIGH_TO_JPEG|IMAGE_W|IMAGE_H|VPP_BUF1_EN" \
  "$CFG" || true

echo "[TXW81X pre_build.sh] all format/yuv definitions:"
grep -R -n -E "#define[[:space:]]+IMAGE_FORMAT|#define[[:space:]]+YUV_MODE|IMAGE_FORMAT|YUV_MODE|YUV422|YUV420|YUV_MODE|JPEG_YUV|DVP_DATA|VPP_DATA" \
  sdk/OpenTXW81X/project \
  sdk/OpenTXW81X/sdk/include \
  sdk/OpenTXW81X/sdk/lib/video/dvp/cmos_sensor \
  sdk/OpenTXW81X/sdk/lib/video/dvp/jpeg \
  2>/dev/null | head -n 300 || true

echo "[TXW81X pre_build.sh] csi format usage:"
grep -n -E "dvp_set_format|vpp_set_ycbcr|vpp_set_mode|IMAGE_FORMAT|YUV_MODE|dvp_set_half_size|dvp_set_exchange" \
  "$CSI_V2" || true

echo "[TXW81X pre_build.sh] DONE"
