#!/bin/sh

if [ "$SENDER" = "mouse.entered" ]; then
  sketchybar --set volume popup.drawing=on
  exit 0
fi

if [ "$SENDER" = "mouse.exited" ]; then
  sketchybar --set volume popup.drawing=off
  exit 0
fi

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"
else
  VOLUME=$(osascript -e 'output volume of (get volume settings)' 2>/dev/null)
fi

case "$VOLUME" in
  [6-9][0-9]|100) ICON="󰕾"
  ;;
  [3-5][0-9]) ICON="󰖀"
  ;;
  [1-9]|[1-2][0-9]) ICON="󰕿"
  ;;
  *) ICON="󰖁"
esac

DEVICE=$(SwitchAudioSource -c 2>/dev/null)
DEVICE_LOWER=$(echo "$DEVICE" | tr '[:upper:]' '[:lower:]')

case "$DEVICE_LOWER" in
  *airpods*)          DEVICE_ICON="ᖳᖰ" ;;
  *headphones*|*earphone*|*wh-1000xm*) DEVICE_ICON="" ;;
  *bluetooth*|*bt*)   DEVICE_ICON="" ;;
  *hdmi*|*display*|*macbook*)   DEVICE_ICON="" ;;
  *dell*)             DEVICE_ICON="D" ;;
  *)                  DEVICE_ICON="" ;;
esac

MUTED=$(osascript -e 'output muted of (get volume settings)' 2>/dev/null)
INPUT=$(osascript -e 'input volume of (get volume settings)' 2>/dev/null)

if [ -n "$DEVICE_ICON" ]; then
  sketchybar --set "$NAME" icon="$ICON" label="${VOLUME}% ${DEVICE_ICON}"
else
  sketchybar --set "$NAME" icon="$ICON" label="${VOLUME}%"
fi

sketchybar --set volume.device label="Device: ${DEVICE}"
sketchybar --set volume.level label="Volume: ${VOLUME}% | Muted: ${MUTED}"
sketchybar --set volume.mic label="Mic: ${INPUT}%"

CACHE_FILE="/tmp/sketchybar_airpods_batt"
if echo "$DEVICE" | grep -qi "airpods"; then
  if [ -f "$CACHE_FILE" ] && [ "$(( $(date +%s) - $(stat -f %m "$CACHE_FILE" 2>/dev/null) ))" -lt 120 ] 2>/dev/null; then
    AIRPODS_BATT=$(cat "$CACHE_FILE")
  else
    (system_profiler SPBluetoothDataType 2>/dev/null | \
      grep -E "(Left|Right|Case) Battery") > "$CACHE_FILE" &
    AIRPODS_BATT=""
  fi

  if [ -n "$AIRPODS_BATT" ]; then
    LEFT=$(echo "$AIRPODS_BATT" | grep "Left"  | sed 's/.*: //')
    RIGHT=$(echo "$AIRPODS_BATT" | grep "Right" | sed 's/.*: //')
    CASE=$(echo "$AIRPODS_BATT" | grep "Case"  | sed 's/.*: //')
    sketchybar --set volume.batt.left label="L: $LEFT"
    sketchybar --set volume.batt.right label="R: $RIGHT"
    sketchybar --set volume.batt.case label="Case: $CASE"
  fi
else
  sketchybar --set volume.batt.left label=""
  sketchybar --set volume.batt.right label=""
  sketchybar --set volume.batt.case label=""
fi
