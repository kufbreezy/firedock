FROM jlesage/firefox

# Set Render port (the container uses 5800 internally)
ENV PORT=5800

# Launch Firefox with Google as homepage
ENV FF_OPEN_URL=https://www.google.com

# Optional: Enable audio support
# ENV WEB_AUDIO=1

# Optional: Enable file manager
# ENV WEB_FILE_MANAGER=1

# Override the default command to bind to Render's PORT
CMD websockify --web /usr/share/novnc/ 0.0.0.0:$PORT localhost:5900 & \
    /usr/bin/supervisord
