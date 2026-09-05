FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and remove snap Firefox
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
    xterm \
    curl \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Firefox from Mozilla PPA (not snap)
RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository ppa:mozillateam/ppa -y && \
    apt-get update && \
    apt-get install -y firefox && \
    apt-get clean

# Block snap Firefox from being installed
RUN echo 'Package: firefox*' > /etc/apt/preferences.d/firefox && \
    echo 'Pin: release o=LP-PPA-mozillateam' >> /etc/apt/preferences.d/firefox && \
    echo 'Pin-Priority: 1001' >> /etc/apt/preferences.d/firefox

# Create working directory
WORKDIR /app

# Copy configuration files
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start.sh /app/start.sh

# Make start script executable
RUN chmod +x /app/start.sh

# Create Fluxbox menu
RUN mkdir -p /root/.fluxbox && \
    echo "[begin] (Fluxbox)" > /root/.fluxbox/menu && \
    echo "  [exec] (Firefox) {firefox}" >> /root/.fluxbox/menu && \
    echo "  [exec] (Firefox Private) {firefox --private-window}" >> /root/.fluxbox/menu && \
    echo "  [separator]" >> /root/.fluxbox/menu && \
    echo "  [exec] (Terminal) {xterm}" >> /root/.fluxbox/menu && \
    echo "  [separator]" >> /root/.fluxbox/menu && \
    echo "  [config] (Configuration)" >> /root/.fluxbox/menu && \
    echo "  [workspaces] (Workspaces)" >> /root/.fluxbox/menu && \
    echo "  [reconfig] (Reconfigure)" >> /root/.fluxbox/menu && \
    echo "  [restart] (Restart)" >> /root/.fluxbox/menu && \
    echo "  [exit] (Exit)" >> /root/.fluxbox/menu && \
    echo "[end]" >> /root/.fluxbox/menu

# Set environment variables
ENV PORT=10000
ENV DISPLAY=:99

# Expose port
EXPOSE $PORT

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
