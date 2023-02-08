disp_n=`hwinfo --monitor --short | grep "" --count`
if [[ $disp_n -eq 2 ]]; then
    export GDK_DPI_SCALE=1.2
    export GDK_SCALE=1.2
    #export QT_SCALE_FACTOR=1.4
    export QT_SCALE_FACTOR=1
else
    export GDK_DPI_SCALE=1
    export GDK_SCALE=1
    export QT_SCALE_FACTOR=1
fi
#export QT_AUTO_SCREEN_SCALE_FACTOR=1
#export QT_WAYLAND_FORCE_DPI=physical
#export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export MOZ_ENABLE_WAYLAND=1
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORM= #wayland-egl
export SDL_VIDEODRIVER= #wayland
export CLUTTER_BACKEND=wayland