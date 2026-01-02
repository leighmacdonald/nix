{ pkgs, lib, ... }:
{
  programs.starship = {
    # "$schema" = "https://starshiprs/config-schema.json";
    enable = true;
    settings = lib.mkMerge [
      (fromTOML (builtins.readFile "${pkgs.starship}/share/starship/presets/catppuccin-powerline.toml"))
      {
        # here goes my custom configurations
        palette = lib.mkForce "catppuccin_mocha";
        add_newline = false;
        direnv = {
          enable = true;
          nix-direnv.enable = true;
          #silent = false;
        };
        os.disabled = lib.mkDefault true;
        status = {
          style = "";
          symbol = "[⨯](bold fg:red bg:lavender)";
          success_symbol = "[✓](bold fg:black bg:lavender)";
          format = "[$symbol$common_meaning$signal_name$maybe_int]($style)";
          map_symbol = true;
          disabled = false;
        };
        git_metrics = {
          disabled = false;
          ignore_submodules = true;
        };
        format = lib.mkForce (
          lib.concatStrings [
            "[](bold red)"
            "$os"
            "$username"
            "[](bold bg:peach fg:red)"
            "$directory"
            "[](bold bg:yellow fg:peach)"
            "$git_branch"
            "$git_status"
            "[](bold fg:yellow bg:green)"
            "$c$rust$golang$nodejs$php$haskell$python"
            "[](bold fg:sapphire bg:lavender)"
            "$status"
            "$time"
            "[ ](bold fg:lavender)"
            "$cmd_duration"
            "$line_break"
            "$character"
          ]

        );

      }
    ];
  };
}
