#!/bin/sh
sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        background.drawing=off \
        icon="$sid" \
        label.padding_right=5                     \
        label.y_offset=1                          \
        label.font="sketchybar-app-font:Regular:16.0" \
        click_script="aerospace workspace $sid" \
        script="$PLUGIN_DIR/aerospace.sh $sid"
done

# for sid in $(aerospace list-workspaces --all); do
#     sketchybar \
#         --add item space.$sid left \
#         --set space.$sid \
#         --subscribe space.$sid aerospace_workspace_change \
#         icon=$sid                                  \
#         background.drawing=off                     \
#         label.font="sketchybar-app-font:Regular:16.0" \
#         click_script="aerospace workspace $sid" \
#         script="$PLUGIN_DIR/aerospace.sh $sid"
#     done
#



  # sketchybar --add space space.$sid left                                 \
  #            --set space.$sid space=$sid                                 \
  #                             icon=$sid                                  \
  #                             label.font="sketchybar-app-font:Regular:16.0" \
  #                             label.padding_right=20                     \
  #                             label.y_offset=-1                          \
  #                             script="$PLUGIN_DIR/space.sh"
