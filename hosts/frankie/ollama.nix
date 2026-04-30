{ pkgsUnstable, ... }:
{
  hardware.nvidia-container-toolkit.enable = false;
  services = {
    ollama = {
      enable = true;
      package = pkgsUnstable.ollama-cuda;
    };
    open-webui.enable = true;
  };
}
