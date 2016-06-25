#!/usr/bin/env python3
import subprocess
import time

#--- set both commands (connect / disconnect) below
connect_command = "/home/lyra/.i3/resolution.sh"
disconnect_command = ""
#---

while True:
    time.sleep(5)
    try:
        subprocess.Popen(["xrandr"])
    except:
        pass
    else:
        break


# function to get the output of xrandr
def get(cmd): return subprocess.check_output(cmd).decode("utf-8")
# - to count the occurrenc of " connected "
def count_screens(xr): return xr.count(" connected ")
# - to run the connect / disconnect command(s)
def run_command(cmd): subprocess.Popen(["/bin/bash", "-c", cmd])

# first count
xr1 = count_screens(get(["xrandr"]))

while True:
    time.sleep(5)
    # second count
    xr2 = count_screens(get(["xrandr"]))
    # check if there is a change in the screen state
    if xr2 != xr1:
        run_command(connect_command)
    xr1 = xr2
