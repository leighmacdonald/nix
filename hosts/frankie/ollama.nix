{ pkgs, ... }:
{
  hardware.nvidia-container-toolkit.enable = false;
  services = {
    ollama = {
      enable = false;
      package = pkgs.ollama-cuda;
    };
    open-webui.enable = true;
  };
}
