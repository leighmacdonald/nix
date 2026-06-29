{
  pkgs,
  pkgsUnstable,
  lib,
  username,
  ...
}:
{
  hardware.nvidia-container-toolkit.enable = lib.mkForce true;
  environment = {
    etc."llm/vllm.Dockerfile" = {
      text = ''
        FROM vllm/vllm-openai:cu129-nightly
        RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends git
        RUN uv pip install --system vllm[audio]==0.11.0
        RUN uv pip install --system git+https://github.com/huggingface/transformers.git
      '';
    };
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
  users.groups.llama-swap = { };
  users.users.llama-swap = {
    isSystemUser = true;
    group = "llama-swap";
    extraGroups = [ "docker" ];
  };
  system.activationScripts.buildVllm = ''
    ${pkgs.docker}/bin/docker build -t vllm-local -f "$(realpath /etc/llm/vllm.Dockerfile)" .
  '';
  system.activationScripts.downloadModels = ''
    mkdir -p /dump/models
    chown -R ${username}:lusers /dump/models
    # Add commands or derivations to populate your models here
  '';
  services.llama-swap = {
    port = 8080;
    enable = true;
    package = pkgsUnstable.llama-swap;
    openFirewall = true;
    settings = {
      globalTTL = 1800;
      macros = {
        docker_bin = "${pkgs.docker}/bin/docker";
        models_dir = "/dump/models";
        binary = "${
          (pkgsUnstable.llama-cpp.override {
            cudaSupport = true;
          })
        }/bin/llama-server";
      };

      models = {
        "Mistral-7B-v0.1" = {
          name = "Mistral-7B-v0.1";
          cmd = "\${docker_bin} run  --device nvidia.com/gpu=all \
              -v /dump/llm/huggingface:/root/.cache/huggingface \
              -p \${PORT}:8000 \
              --ipc=host \
              vllm-local \
              --model mistralai/Mistral-7B-v0.1";
        };
        "Nemotron-3-Nano-Omni-30B" = {
          name = "Nemotron-3-Nano-Omni-30B";
          cmd = "\${docker_bin} run  --device nvidia.com/gpu=all \
              -v /dump/llm/huggingface:/root/.cache/huggingface \
              -p \${PORT}:8000 \
              --ipc=host \
              vllm-local \
              --model nvidia/Nemotron-3-Nano-Omni-30B-A3B-Reasoning-FP8";
        };

        # gemma-4-31B = 60 layers
        "gemma-4-31B-it-UD-Q5_K_XL-thinking" = {
          name = "gemma-4-31B-it-UD-Q5_K_XL";
          cmd = "\${binary}
             -m \${models_dir}/gemma-4-31B-it-UD-Q5_K_XL.gguf
             -ngl 50 \
             --temp 1.0 \
             --top-p 0.95 \
             --top-k 64  \
             --port \${PORT}";
        };

        # gemma-4-26B = 30 layers
        "gemma-4-26B-A4B-it-UD-Q4_K_XL-thinking" = {
          name = "gemma-4-26B-A4B-it-UD-Q4_K_XL";
          cmd = "\${binary}
             -m \${models_dir}/gemma-4-26B-A4B-it-UD-Q4_K_XL.gguf
             --temp 1.0 \
             --top-p 0.95 \
             --top-k 64  \
             --port \${PORT}";
        };

        "gemma-4-26B-A4B-it-UD-Q4_K_XL" = {
          name = "gemma-4-26B-A4B-it-UD-Q4_K_XL";
          cmd = "\${binary}
             -m \${models_dir}/gemma-4-26B-A4B-it-UD-Q4_K_XL.gguf
             --temp 1.0 \
             --top-p 0.95 \
             --top-k 64  \
             --port \${PORT} \
             --chat-template-kwargs '{\"enable_thinking\":false}'";
        };

        # 64 layers total for qwen36-27b
        "Qwen3.6-27B-Q4_K_M-MTP" = {
          name = "Qwen3.6-27B-Q4_K_M-MTP";
          cmd = "\${binary} \
             -m \${models_dir}/Qwen3.6-27B-Q4_K_M-MTP.gguf \
             -ngl 55 \
             --ctx-size 128000 \
             --no-mmproj-offload \
             --no-context-shift \
             --kv-unified \
             --spec-type draft-mtp \
             --spec-draft-n-max 2 \
             --spec-draft-p-min 0.75 \
             -fa on --jinja --no-mmap \
             --cache-ram -1 \
             --no-warmup -np 1 -n 32768 \
             --cache-type-k q8_0 \
             --cache-type-v q8_0 \
             --temp 0.6 \
             --min-p 0.00 \
             --top-k 20 \
             --top-p 0.8 \
             --presence-penalty 0.0 \
             --repeat-penalty 1.05 \
             --fit off \
             --reasoning on \
             --chat-template-kwargs '{\"preserve_thinking\":true}' \
             --port \${PORT}";
        };
        # https://huggingface.co/unsloth/Qwen3.6-35B-A3B-MTP-GGUF
        # 40 layer
        "Qwen3.6-35B-A3B-UD-Q4_K_XL" = {
          name = "Qwen3.6-35B-A3B-UD-Q4_K_XL";
          cmd = "\${binary} \
            -m \${models_dir}/Qwen3.6-35B-A3B-UD-Q4_K_XL.gguf \
            --chat-template-kwargs '{\"enable_thinking\":false}' \
            -ngl 30 \
            --ctx-size 128000 \
            --no-mmproj-offload \
            --no-context-shift \
            --kv-unified \
            --spec-type draft-mtp \
            --spec-draft-n-max 2 \
            --spec-draft-p-min 0.75 \
            -fa on --jinja --no-mmap \
            --cache-ram -1 \
            --no-warmup -np 1 -n 32768 \
            --cache-type-k q4_0 \
            --cache-type-v q4_0 \
            --temp 0.6 \
            --min-p 0.00 \
            --top-k 20 \
            --top-p 0.8 \
            --port \${PORT} \
            --presence-penalty 0.0 \
            --repeat-penalty 1.05 \
            --fit off \
            --reasoning on";
        };
        "Qwen3.6-35B-A3B-UD-Q4_K_XL-thinking" = {
          name = "Qwen3.6-35B-A3B-UD-Q4_K_XL";
          cmd = "\${binary} \
            -m \${models_dir}/Qwen3.6-35B-A3B-UD-Q4_K_XL.gguf \
             -ngl 30 \
             --ctx-size 128000 \
             --no-mmproj-offload \
             --no-context-shift \
             --kv-unified \
             --spec-type draft-mtp \
             --spec-draft-n-max 2 \
             --spec-draft-p-min 0.75 \
             -fa on --jinja --no-mmap \
             --cache-ram -1 \
             --no-warmup -np 1 -n 32768 \
             --cache-type-k q4_0 \
             --cache-type-v q4_0 \
             --temp 0.6 \
             --min-p 0.00 \
             --top-k 20 \
             --top-p 0.95 \
             --presence-penalty 0.0 \
             --repeat-penalty 1.05 \
             --fit off \
             --reasoning on \
             --embeddings \
             --chat-template-kwargs '{\"preserve_thinking\":true}' \
             --port \${PORT}";
        };
      };
    };
  };
}
