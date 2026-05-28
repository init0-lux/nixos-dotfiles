{ config, pkgs, ... }:

{
  # ── User account ───────────────────────────────────────────────
  users.users.init0 = {
    isNormalUser = true;
    description = "init0";
    extraGroups = [ "networkmanager" "wheel" "kvm" "adbusers" "vboxusers" "wireshark" "docker" ];
  };
  users.defaultUserShell = pkgs.zsh;
  security.sudo.wheelNeedsPassword = false;

  # ── ZSH Config ──────────────────────────────────────────────────
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    histSize = 10000;
    histFile = ".zsh/history";
    promptInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    '';
  };

  # ── NixOS Program Options ───────────────────────────────────────
  programs.firefox = {
    enable = true;
    preferences = {
      "pdfjs.cursorToolOnLoad" = 1;
      "pdfjs.defaultZoomValue" = "page-fit";
      "pdfjs.scrollModeOnLoad" = 1;
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };
  programs.kdeconnect.enable = true;
  programs.adb.enable = true;
  programs.wireshark.enable = true;
  programs.git.enable = true;
  programs.direnv.enable = true;
  programs.tmux = {
    enable = true;
    clock24 = true;
    newSession = true;
    escapeTime = 0;
    plugins = with pkgs.tmuxPlugins; [ better-mouse-mode resurrect continuum ];
    extraConfig = ''
      unbind C-b
      set -g prefix C-s
      bind C-s send-prefix
      bind -n M-\\ split-window -h -c "#{pane_current_path}"
      bind -n M-\- split-window -v -c "#{pane_current_path}"
      bind -n M-f new-window -c "#{pane_current_path}"
      bind -n M-k select-pane -L
      bind -n M-h select-pane -R
      bind -n M-i select-pane -U
      bind -n M-n select-pane -D
      bind-key -n M-1 select-window -t 0
      bind-key -n M-2 select-window -t 1
      bind-key -n M-3 select-window -t 2
      bind-key -n M-4 select-window -t 3
      bind-key -n M-5 select-window -t 4
      bind-key -n M-6 select-window -t 5
      bind-key -n M-7 select-window -t 6
      bind-key -n M-8 select-window -t 7
      bind-key -n M-9 select-window -t 8
      bind -n M-Right next-window
      bind -n M-l next-window
      bind -n M-Left previous-window
      bind -n M-r previous-window
      set-option -g allow-rename on
      set -g default-shell /run/current-system/sw/bin/zsh
      bind f new-window -c "#{pane_current_path}"
      set -g @resurrect-strategy-nvim 'session'
      set -g @resurrect-strategy-vim 'session'
      set -g @resurrect-capture-pane-contents 'on'
      set -g @continuum-restore 'on'
      set -g @continuum-save-interval '3'
      set -g @continuum-boot 'on'
    '';
  };
}
