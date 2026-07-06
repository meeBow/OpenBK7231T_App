#!/bin/sh

echo "=================================================="
echo "[TXW81X pre_build.sh] RUNNING - inspect csi vpp pipeline"
echo "PWD=$(pwd)"
echo "=================================================="

echo "[TXW81X pre_build.sh] csi/vpp files:"
ls -la sdk/OpenTXW81X/sdk/lib/video/dvp/cmos_sensor 2>/dev/null || true
ls -la sdk/OpenTXW81X/sdk/include/lib/video/dvp/cmos_sensor 2>/dev/null || true
ls -la sdk/OpenTXW81X/sdk/lib/video/dvp 2>/dev/null || true

echo "[TXW81X pre_build.sh] csi_v2 core:"
grep -R -n -E "vpp_|dvp_|scale_|prc_|yuv|rgb|ycbcr|threshold|mode|sensor|cmos|jpg|jpeg|buf|psram|put_psram|set_" \
  sdk/OpenTXW81X/sdk/lib/video/dvp/cmos_sensor/csi_v2.c \
  sdk/OpenTXW81X/sdk/include/lib/video/dvp/cmos_sensor/csi.h \
  2>/dev/null | head -n 300 || true

echo "[TXW81X pre_build.sh] vpp usage:"
grep -R -n -E "vpp_set_|vpp_open|vpp_close|hgvpp|VPP|vpp_" \
  sdk/OpenTXW81X/sdk/lib \
  sdk/OpenTXW81X/project \
  2>/dev/null | head -n 300 || true

echo "[TXW81X pre_build.sh] scale/prc usage:"
grep -R -n -E "scale_set_|scale_open|scale_close|prc_set_|prc_run|PRC|SCALE" \
  sdk/OpenTXW81X/sdk/lib \
  sdk/OpenTXW81X/project \
  2>/dev/null | head -n 300 || true

echo "[TXW81X pre_build.sh] DONE"
