#!/bin/sh

echo "=================================================="
echo "[TXW81X pre_build.sh] RUNNING - inspect image controls"
echo "PWD=$(pwd)"
echo "=================================================="

echo "[TXW81X pre_build.sh] image control candidates:"
grep -R -n -E "brightness|contrast|saturation|sharp|sharpness|gamma|ae|awb|gain|exposure|black|level|color|matrix|yuv|rgb|vpp|prc|scale" \
  sdk/OpenTXW81X/sdk/include \
  sdk/OpenTXW81X/sdk/lib/video \
  sdk/OpenTXW81X/project \
  2>/dev/null | head -n 500 || true

echo "[TXW81X pre_build.sh] sensor register candidates:"
grep -R -n -E "GC0329|SP0A19|BF3A03|SP0828|SP0A20|gamma|contrast|saturation|brightness|awb|ae|gain|exposure|0x[0-9a-fA-F]" \
  sdk/OpenTXW81X/sdk \
  2>/dev/null | head -n 500 || true

echo "[TXW81X pre_build.sh] DONE"
