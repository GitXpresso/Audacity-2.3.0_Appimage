#! /usr/bin/env bash

case "$(gsettings get org.gnome.desktop.interface color-scheme 2> /dev/null)" in
    "'prefer-dark'")  GTK_THEME_VARIANT="dark";;
    "'prefer-light'") GTK_THEME_VARIANT="light";;
    *)                GTK_THEME_VARIANT="light";;
esac
APPIMAGE_GTK_THEME="${APPIMAGE_GTK_THEME:-"Adwaita:$GTK_THEME_VARIANT"}" # Allow user to override theme (discouraged)

export APPDIR="${APPDIR:-"$(dirname "$(realpath "$0")")"}" # Workaround to run extracted AppImage
export GTK_DATA_PREFIX="$APPDIR"
export GTK_THEME="$APPIMAGE_GTK_THEME" # Custom themes are broken
export GDK_BACKEND=x11 # Crash with Wayland backend on Wayland
export XDG_DATA_DIRS="$APPDIR/usr/share:/usr/share:$XDG_DATA_DIRS" # g_get_system_data_dirs() from GLib
export GSETTINGS_SCHEMA_DIR="$APPDIR//usr/share/glib-2.0/schemas"
export GI_TYPELIB_PATH="$APPDIR//usr/lib/girepository-1.0"
export GDK_PIXBUF_MODULE_FILE="$APPDIR//usr/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache"
