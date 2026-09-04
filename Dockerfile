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
    firefox \
    xterm \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Create Fluxbox menu
RUN mkdir -p /root/.fluxbox && \
    echo "[begin] (Fluxbox)" > /root/.fluxbox/menu && \
    echo "  [exec] (Firefox) {firefox}" >> /root/.fluxbox/menu && \
    echo "  [exec] (Terminal) {xterm}" >> /root/.fluxbox/menu && \
    echo "  [config] (Configuration)" >> /root/.fluxbox/menu && \
    echo "  [workspaces] (Workspaces)" >> /root/.fluxbox/menu && \
    echo "  [reconfig] (Reconfigure)" >> /root/.fluxbox/menu && \
    echo "  [restart] (Restart)" >> /root/.fluxbox/menu && \
    echo "  [exit] (Exit)" >> /root/.fluxbox/menu && \
    echo "[end]" >> /root/.fluxbox/menu

ENV PORT=10000
ENV DISPLAY=:99

EXPOSE $PORT

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
