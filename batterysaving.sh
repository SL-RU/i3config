#!/bin/dash

check_and_set_refresh() {
    read -r status < /sys/class/power_supply/BAT0/status
    refresh=$(swaymsg -t get_outputs -r | jq '(.[] | select(.name == "eDP-1")).current_mode.refresh')

    if [ "$status" = "Discharging" ] && [ "$refresh" != "60000" ]; then
        swaymsg output eDP-1 mode 2880x1800@60.000Hz
    elif [ "$refresh" != "120000" ] && [ "$status" != "Discharging" ]; then
        swaymsg output eDP-1 mode 2880x1800@120.000Hz
    fi
}

while true; do
    check_and_set_refresh
    sleep 1
done