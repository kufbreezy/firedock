#!/bin/bash

echo "Starting firedock with Firefox on Render..."

# Setup display
export DISPLAY=:99

# Start Xvfb (virtual display)
Xvfb $DISPLAY -screen 0 1280x720x24 &
XVFB_PID=$!
echo "Xvfb started with PID: $XVFB_PID"

# Wait for Xvfb to initialize
sleep 3

# Start fluxbox window manager
fluxbox &
FLUXBOX_PID=$!
echo "Fluxbox started with PID: $FLUXBOX_PID"

# Wait for fluxbox to initialize
sleep 2

# Check if firefox or firefox-esr is installed
if command -v firefox-esr &> /dev/null; then
    FIREFOX_CMD="firefox-esr"
elif command -v firefox &> /dev/null; then
    FIREFOX_CMD="firefox"
else
    echo "Error: Firefox not found!"
    FIREFOX_CMD=""
fi

# Launch Firefox if available
if [ -n "$FIREFOX_CMD" ]; then
    $FIREFOX_CMD --new-window https://www.google.com &
    FIREFOX_PID=$!
    echo "Firefox started with PID: $FIREFOX_PID"
else
    echo "Firefox not installed, skipping..."
fi

# Start x11vnc server
x11vnc -display $DISPLAY -forever -nopw -shared -rfbport 5900 &
X11VNC_PID=$!
echo "x11vnc started with PID: $X11VNC_PID"

# Start noVNC web client on Render's PORT
websockify --web /usr/share/novnc/ 0.0.0.0:$PORT localhost:5900 &
WEBSOCKIFY_PID=$!
echo "websockify started on port $PORT with PID: $WEBSOCKIFY_PID"

echo "All services started successfully!"
echo "Access your VNC at: http://localhost:$PORT/vnc.html"

# Keep the container running
wait $WEBSOCKIFY_PID
