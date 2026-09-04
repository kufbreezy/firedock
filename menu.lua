# Create this file at /root/.fluxbox/menu
# You can also create it in your project and copy via Dockerfile

[begin] (Fluxbox)
  [exec] (Firefox) {firefox}
  [exec] (Firefox - Private) {firefox --private-window}
  [separator]
  [exec] (Terminal) {xterm}
  [separator]
  [submenu] (VNC)
    [exec] (Set Password) {x11vnc -storepasswd}
  [end]
  [separator]
  [config] (Configuration)
  [workspaces] (Workspaces)
  [reconfig] (Reconfigure)
  [restart] (Restart)
  [exit] (Exit)
[end]
