{ pkgs, ... }:
{
  hardware.nvidia-container-toolkit.enable = true;
  services = {
    ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
    };
    open-webui.enable = true;
  };
}
