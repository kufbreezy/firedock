FROM linuxserver/firefox:latest

# Install VNC support
RUN apt-get update && apt-get install -y \
    x11vnc \
    fluxbox \
    supervisor \
    websockify \
    novnc \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /app

# Copy configuration files
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Set environment variables
ENV PORT=10000
ENV DISPLAY=:99

# Expose port
EXPOSE $PORT

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
