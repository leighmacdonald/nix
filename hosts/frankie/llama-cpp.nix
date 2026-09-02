{
  pkgs,
  pkgsUnstable,
  lib,
  username,
  ...
}: let
  models_dir = "/projects/models";
  binary = "${
    (pkgsUnstable.llama-cpp.override {
      cudaSupport = true;
    })
  }/bin/llama-server";
in {
  hardware.nvidia-container-toolkit.enable = lib.mkForce true;
  environment = {
    # etc."llm/vllm.Dockerfile" = {
    #   text = ''
    #     FROM vllm/vllm-openai:latest-cu129
    #     RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends git
    #     RUN uv pip install --system causal-conv1d mamba-ssm --no-build-isolation
    #     RUN uv pip install --system vllm[audio]==0.23.0
    #     # RUN uv pip install --system git+https://github.com/huggingface/transformers.git
    #   '';
    # };
    systemPackages = [
      pkgs.python314Packages.huggingface-hub
      pkgs.python314Packages.hf-transfer
      pkgsUnstable.llama-swap
      (pkgsUnstable.llama-cpp.override {
        cudaSupport = true;
        rocmSupport = false;
        metalSupport = false;
        # Enable BLAS for optimized CPU layer performance (OpenBLAS)
        # blasSupport = true;
      })
    ];
  };
  users.groups.llama-swap = {};
  users.users.llama-swap = {
    isSystemUser = true;
    group = "llama-swap";
    extraGroups = ["docker"];
  };
  # system.activationScripts.buildVllm = ''
  #   ${pkgs.docker}/bin/docker build -t vllm-local -f "$(realpath /etc/llm/vllm.Dockerfile)" .
  # '';
  system.activationScripts.downloadModels = ''
    mkdir -p /projects/models
    chown -R ${username}:lusers /projects/models
    # Add commands or derivations to populate your models here
  '';
  systemd.services.llama-swap.serviceConfig = {
    EnvironmentFile = "/etc/llama-swap/envfile";
  };
  services.llama-swap = {
    port = 8080;
    listenAddress = "0.0.0.0";
    enable = true;
    package = pkgsUnstable.llama-swap;
    openFirewall = true;
    settings = {
      globalTTL = 1800;
      apiKeys = [
        "\${env.API_KEY_1}"
        "\${env.API_KEY_2}"
      ];
      macros = {
        inherit models_dir;
        inherit binary;
        docker_bin = "${pkgs.docker}/bin/docker";
        common_args = "--fit on -fitt 1024 --no-webui";
      };
      # apiKeys = [
      #   "$(env.API_KEY_1)"
      #   "$(env.API_KEY_2)"
      # ];
      models = {
        #               --spec-type draft-mtp \
        #--spec-draft-n-max 7 \
        #--spec-draft-p-min 0.75 \
        # default, (off), low, medium, high or max
        "Qwen3.8-27B-UD-Q4_K_XL" = {
          name = "Qwen3.8-27B-UD-Q4_K_XL";
          cmd = "\${binary} \
              -m \${models_dir}/Qwen3.8-27B-UD-Q4_K_XL.gguf \
              -ngl 65  \
              --ctx-size 200000 \
              --no-mmproj-offload \
              --kv-unified \
              -fa on --jinja \
              --cache-ram -1 \
              --cache-type-k q4_0 \
              --cache-type-v q4_0 \
              --temp 1.0 \
              --min-p 0.0 \
              --top-k 20 \
              --top-p 0.95 \
              --presence-penalty 0.0 \
              --repeat-penalty 1.0 \
              --reasoning on \
              --reasoning-preserve \
              --chat-template-kwargs '{\"reasoning-effort\": \"xhigh\"}' \
              --port \${PORT}";
        };
        "Qwen3.8-27B-UD-Q4_K_M" = {
          name = "Qwen3.8-27B-UD-Q4_K_M";
          cmd = "\${binary} \
              -m \${models_dir}/Qwen3.8-27B-UD-Q4_K_M.gguf \
              -ngl 65  \
              --spec-type draft-mtp \
              --spec-draft-n-max 7 \
              --spec-draft-p-min 0.75 \
              --ctx-size 128000 \
              --no-mmproj-offload \
              --kv-unified \
              -fa on --jinja \
              --cache-ram -1 \
              --cache-type-k q4_0 \
              --cache-type-v q4_0 \
              --temp 1.0 \
              --min-p 0.0 \
              --top-k 20 \
              --top-p 0.95 \
              --presence-penalty 0.0 \
              --repeat-penalty 1.0 \
              --reasoning on \
              --reasoning-preserve \
              --chat-template-kwargs '{\"reasoning-effort\": \"xhigh\"}' \
              --port \${PORT}";
        };
      };
    };
  };
}
