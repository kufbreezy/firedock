FROM jlesage/firefox

# Render injects PORT (default 10000). Tell the image to listen on it.
ENV WEB_LISTENING_PORT=$PORT

# Optional but useful defaults
ENV FF_OPEN_URL=https://www.google.com
ENV DARK_MODE=1
ENV WEB_AUDIO=1
ENV WEB_FILE_MANAGER=1

# Optional Firefox prefs (examples)
ENV FF_PREF_HOMEPAGE=browser.startup.homepage=\"https://duckduckgo.com\"
ENV FF_PREF_POPUPS=dom.disable_open_during_load=false

# Do NOT override CMD / ENTRYPOINT.
# The base image’s init system starts everything correctly.
