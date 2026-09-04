FROM jlesage/firefox:latest

# Force the web UI to listen on the port Render expects
ENV WEB_LISTENING_PORT=10000
ENV VNC_LISTENING_PORT=-1
ENV KEEP_APP_RUNNING=1

# Optional but recommended
ENV DISPLAY_WIDTH=1280
ENV DISPLAY_HEIGHT=720
