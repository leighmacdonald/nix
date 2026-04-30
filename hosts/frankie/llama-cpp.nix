{ pkgsUnstable, ... }:
{
  environment = {
    systemPackages = [
      pkgsUnstable.llama-swap
      (pkgsUnstable.llama-cpp.override { cudaSupport = true; })
    ];
  };
}
