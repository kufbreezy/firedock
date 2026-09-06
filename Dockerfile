FROM jlesage/firefox

# These are the only environment variables we want baked in.
# Everything else (especially ports) must be set at runtime by Render.
ENV FF_OPEN_URL=https://www.google.com
ENV DARK_MODE=1
ENV WEB_AUDIO=1
ENV WEB_FILE_MANAGER=1
ENV DISPLAY_WIDTH=1280
ENV DISPLAY_HEIGHT=720
