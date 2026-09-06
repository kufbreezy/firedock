# FROM jlesage/firefox

# # Set Render port (the container uses 5800 internally)
# ENV PORT=5800

# # Launch Firefox with Google as homepage
# ENV FF_OPEN_URL=https://www.google.com

# # Optional: Enable audio support
# # ENV WEB_AUDIO=1

# # Optional: Enable file manager
# # ENV WEB_FILE_MANAGER=1

# # Override the default command to bind to Render's PORT
# CMD websockify --web /usr/share/novnc/ 0.0.0.0:$PORT localhost:5900 & \
#     /usr/bin/supervisord


FROM jlesage/firefox

# Web port (Render expects this)
ENV PORT=5800

# Firefox settings
ENV FF_OPEN_URL=https://www.google.com
ENV DARK_MODE=1
ENV WEB_AUDIO=1
ENV WEB_FILE_MANAGER=1

# Optional: Set custom preferences
ENV FF_PREF_HOMEPAGE=browser.startup.homepage=\"https://duckduckgo.com\"
ENV FF_PREF_POPUPS=dom.disable_open_during_load=false

# Override command for Render
CMD websockify --web /usr/share/novnc/ 0.0.0.0:$PORT localhost:5900 & \
    /usr/bin/supervisord
