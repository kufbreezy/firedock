FROM jlesage/firefox

# Runtime PORT is injected by Render.  We must set WEB_LISTENING_PORT
# at *runtime*, not at build time.
# The entrypoint of the base image already sources /etc/cont-env.d,
# so we just make sure the variable is present.

# Useful defaults (all of these are supported by the image)
ENV FF_OPEN_URL=https://www.google.com
ENV DARK_MODE=1
ENV WEB_AUDIO=1
ENV WEB_FILE_MANAGER=1
ENV DISPLAY_WIDTH=1280
ENV DISPLAY_HEIGHT=720

# Optional Firefox prefs
ENV FF_PREF_HOMEPAGE=browser.startup.homepage=\"https://duckduckgo.com\"

# Do NOT override CMD / ENTRYPOINT.
# The base image’s /init + supervisor already start everything correctly.
