{
  config,
  pkgs,
  antigravity-nix,
  ...
}:

{
  home.stateVersion = "25.11";

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # Core LSP + Completion
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      friendly-snippets

      # Syntax
      nvim-treesitter.withAllGrammars

      # Telescope
      telescope-nvim
      plenary-nvim

      # UI
      lualine-nvim
      gitsigns-nvim
      which-key-nvim
      nvim-autopairs
      comment-nvim

      # Git
      vim-fugitive

      # Nix
      vim-nix

      # CoPilot
      copilot-lua
      copilot-cmp
      CopilotChat-nvim
    ];
  };

  xdg.configFile."nvim".source = ./nvim;

  home.packages = with pkgs; [
    # Required binaries
    ripgrep
    fd

    # Language servers
    gopls
    rust-analyzer
    typescript-language-server
    eslint
    nil
    dart
    nodejs
    go

    # Custom Antigravity packages
    antigravity-nix.packages.${pkgs.system}.default
  ];
}
