FROM dorowu/ubuntu-desktop-lxde-vnc

# Install Firefox
RUN apt-get update && apt-get install -y firefox

# Set Render port
ENV PORT=10000

# Start everything directly - no start.sh needed!
CMD websockify --web /usr/share/novnc/ 0.0.0.0:$PORT localhost:5900 & \
    firefox --new-window https://www.google.com & \
    /usr/bin/supervisord
