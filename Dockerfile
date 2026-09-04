FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    xvfb \
    x11vnc \
    fluxbox \
    wget \
    supervisor \
    websockify \
    novnc \
    tigervnc-standalone-server \
    tigervnc-common \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /app

# Copy configuration files
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start.sh /app/start.sh

# Make start script executable
RUN chmod +x /app/start.sh

# Set environment variables
ENV PORT=10000
ENV DISPLAY=:99

# Expose port
EXPOSE $PORT

# Start supervisord
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
