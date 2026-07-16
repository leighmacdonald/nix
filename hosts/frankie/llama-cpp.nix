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
  systemd.services.autocomplete = {
    description = "llama-server for autocomplete";
    enable = false;
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "simple";
      User = username;
      Restart = "always";
      ExecStart = "${binary} -m ${models_dir}/fitm/sweep-next-edit-1.5b.q8_0.v2.gguf -ngl 99 -c 8192 --host 0.0.0.0 --port 8081";
    };
  };

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
        # "Nemotron-3-Nano-Omni-30B" = {
        #   name = "Nemotron-3-Nano-Omni-30B";
        #   cmd = "\${docker_bin} run  --device nvidia.com/gpu=all \
        #       -v /dump/llm/huggingface:/root/.cache/huggingface \
        #       -p \${PORT}:8000 \
        #       --ipc=host \
        #       vllm-local \
        #       --trust-remote-code nvidia/Nemotron-3-Nano-Omni-30B-A3B-Reasoning-FP8";
        # };
        #
        "North-Mini-Code-1.0-UD-Q4_K_M" = {
          name = "North-Mini-Code-1.0-UD-Q4_K_M";
          cmd = "\${binary}
             -m \${models_dir}/North-Mini-Code-1.0-UD-Q4_K_M.gguf \
             -e --temp 1.0 --top-p 0.95 \
             --jinja \
             \${common_args} \
             --port \${PORT}";
        };
        "North-Mini-Code-1.0-UD-Q5_K_M" = {
          name = "North-Mini-Code-1.0-UD-Q5_K_M";
          cmd = "\${binary}
             -m \${models_dir}/North-Mini-Code-1.0-UD-Q5_K_M.gguf \
             -e --temp 1.0 --top-p 0.95 \
             --jinja \
             \${common_args} \
             --port \${PORT}";
        };

        "Nemotron-3-Nano-30B-A3B-UD-Q4_K_XL" = {
          name = "Nemotron-3-Nano-30B-A3B-UD-Q4_K_XL";
          cmd = "\${binary}
             -m \${models_dir}/Nemotron-3-Nano-30B-A3B-UD-Q4_K_XL.gguf \
             --temp 1.0 \
             --top-p 0.95 \
             --top-k 64  \
             \${common_args} \
             --port \${PORT}";
        };
        # codegemma-1.1-2b-f16.gguf
        # codegemma-7b-f16.gguf
        # https://huggingface.co/google/gemma-7b-it/discussions/38#65d7b14adb51f7c160769fa1
        "codegemma-1.1-2b-f16" = {
          name = "codegemma-1.1-2b-f16";
          cmd = "\${binary}
             -m \${models_dir}/fitm/codegemma-1.1-2b-f16.gguf \
             -ngl 99 \
             -e --temp 0 --repeat-penalty 1.0 \
             --port \${PORT}";
        };
        "codegemma-7b-f16" = {
          name = "codegemma-7b-f16";
          cmd = "\${binary}
             -m \${models_dir}/fitm/codegemma-7b-f16.gguf \
             -ngl 99 \
             -e --temp 0 --repeat-penalty 1.0  \
             \${common_args} \
             --port \${PORT}";
        };

        # omnicoder-9b-q8_0.gguf
        "omnicoder-9b-q8_0" = {
          name = "omnicoder-9b-q8_0";
          cmd = "\${binary}
             -m \${models_dir}/fitm/omnicoder-9b-q8_0.gguf \
             -ngl 99 \
             -c 8192 \
             \${common_args} \
             --port \${PORT}";
        };
        # sweep-next-edit-v2-7b-q8_0.gguf https://huggingface.co/Cyanophyte/sweep-next-edit-v2-7B-Q8_0-GGUF
        "sweep-next-edit-v2-7b-q8_0" = {
          name = "sweep-next-edit-v2-7b-q8_0";
          cmd = "\${binary}
             -m \${models_dir}/fitm/sweep-next-edit-v2-7b-q8_0.gguf \
             -ngl 99 \
             -c 8192 \
             \${common_args} \
             --port \${PORT}";
        };
        # sweep-next-edit-1.5b.q8_0.v2.gguf https://huggingface.co/sweepai/sweep-next-edit-1.5B
        "sweep-next-edit-1.5b.q8_0.v2" = {
          name = "sweep-next-edit-1.5b.q8_0.v2";
          cmd = "\${binary}
             -m \${models_dir}/fitm/sweep-next-edit-1.5b.q8_0.v2.gguf \
             -ngl 99 \
             -c 8192 \
             \${common_args} \
             --port \${PORT}";
        };

        # https://huggingface.co/unsloth/gemma-4-31B-it-qat-GGUF 60layer 256k dense
        "gemma-4-26B-A4B-it-qat-UD-Q4_K_XL" = {
          name = "gemma-4-26B-A4B-it-qat-UD-Q4_K_XL";
          cmd = "\${binary}
              -m \${models_dir}/gemma-4-26B-A4B-it-qat-UD-Q4_K_XL.gguf \
              --mmproj \${models_dir}/gemma-4-26B-A4B-it-qat-UD-Q4_K_XL-mmproj-F16.gguf \
              --model-draft \${models_dir}/mtp-gemma-4-26B-A4B-it-Q8_0.gguf \
              --spec-type draft-mtp --spec-draft-n-max 4 \
              -fa on --temp 1.0 --top-p 0.95 --top-k 64 \
              --ctx-size 128000 \
              --cache-type-k q4_0 \
              --cache-type-v q4_0 \
              \${common_args} \
              --port \${PORT}";
        };
        # https://huggingface.co/unsloth/gemma-4-26B-A4B-it-qat-GGUF 30layer moe 256k
        "gemma-4-31B-it-qat-UD-Q4_K_XL" = {
          name = "gemma-4-31B-it-qat-UD-Q4_K_XL";
          cmd = "\${binary}
              -m \${models_dir}/gemma-4-31B-it-qat-UD-Q4_K_XL.gguf \
              --mmproj \${models_dir}/gemma-4-31B-it-qat-UD-Q4_K_XL-mmproj-F16.gguf \
              --model-draft \${models_dir}/mtp-gemma-4-31B-it-Q8_0.gguf \
              --spec-type draft-mtp --spec-draft-n-max 4 \
              -fa on --temp 1.0 --top-p 0.95 --top-k 64 \
              --ctx-size 128000 \
              --cache-type-k q4_0 \
              --cache-type-v q4_0 \
              -ngl 20 \
              \${common_args} \
              --port \${PORT}";
        };

        # 64 layers total for qwen36-27b
        # https://github.com/rapatel0/rq-models
        "Qwen3.6-27B-Q4_K_M-MTP" = {
          name = "Qwen3.6-27B-Q4_K_M-MTP";
          cmd = "\${binary} \
              -m \${models_dir}/Qwen3.6-27B-Q4_K_M-MTP.gguf \
              -ngl 64 \
              --ctx-size 128000 \
              --no-mmproj-offload \
              --no-context-shift \
              --kv-unified \
              --spec-type draft-mtp \
              --spec-draft-n-max 6 \
              --spec-draft-p-min 0.75 \
              -fa on --jinja \
              --cache-ram -1 \
              --no-warmup \
              --mlock \
              --cache-type-k q4_0 \
              --cache-type-v q4_0 \
              --temp 0.6 \
              --min-p 0.00 \
              --top-k 20 \
              --top-p 0.95 \
              --presence-penalty 0.0 \
              --repeat-penalty 1.05 \
              --reasoning off \
              --port \${PORT}";
        };

        "Qwen3.6-27B-Q4_K_M-MTP-think" = {
          name = "Qwen3.6-27B-Q4_K_M-MTP-think";
          cmd = "\${binary} \
              -m \${models_dir}/Qwen3.6-27B-Q4_K_M-MTP.gguf \
              -ngl 64 \
              --ctx-size 128000 \
              --no-mmproj-offload \
              --no-context-shift \
              --kv-unified \
              --spec-type draft-mtp \
              --spec-draft-n-max 6 \
              --spec-draft-p-min 0.75 \
              -fa on --jinja \
              --cache-ram -1 \
              --no-warmup \
              --mlock \
              --cache-type-k q4_0 \
              --cache-type-v q4_0 \
              --temp 0.6 \
              --min-p 0.00 \
              --top-k 20 \
              --top-p 0.95 \
              --presence-penalty 0.0 \
              --repeat-penalty 1.05 \
              --reasoning on \
              --chat-template-kwargs '{\"preserve_thinking\":true}' \
              --port \${PORT}";
        };
        # https://huggingface.co/Jackrong/Qwopus3.6-27B-Coder-Compat-MTP-GGUF
        #               --chat-template-file /projects/models/qwen36-chat_template.jinja \
        "Qwopus3.6-27B-Coder-MTP-Q4_K_M" = {
          name = "Qwopus3.6-27B-Coder-MTP-Q4_K_M";
          cmd = "\${binary} \
              -m \${models_dir}/Qwopus3.6-27B-Coder-Compat-MTP-Q4_K_M.gguf \
              -ngl 64 \
              --ctx-size 128000 \
              --no-mmproj-offload \
              --no-context-shift \
              --kv-unified \
              --spec-type draft-mtp \
              --spec-draft-n-max 6 \
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
              --presence-penalty 0.0 \
              --repeat-penalty 1.05 \
              --reasoning off \
              --chat-template-file /projects/models/qwen36-chat_template.jinja \
              --chat-template-kwargs '{\"preserve_thinking\":true}' \
        		  --port \${PORT}";
        };
        "Qwopus3.6-27B-Coder-MTP-Q4_K_M-think" = {
          name = "Qwopus3.6-27B-Coder-MTP-Q4_K_M-think";
          cmd = "\${binary} \
              -m \${models_dir}/Qwopus3.6-27B-Coder-Compat-MTP-Q4_K_M.gguf \
              -ngl 64 \
              --ctx-size 128000 \
              --no-mmproj-offload \
              --no-context-shift \
              --kv-unified \
              --spec-type draft-mtp \
              --spec-draft-n-max 6 \
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
              --presence-penalty 0.0 \
              --repeat-penalty 1.05 \
              --reasoning on \
              --chat-template-file /projects/models/qwen36-chat_template.jinja \
              --chat-template-kwargs '{\"preserve_thinking\":true}' \
              --port \${PORT}";
        };
        "Qwopus3.6-27B-Coder-MTP-Q5_K_M" = {
          name = "Qwopus3.6-27B-Coder-MTP-Q5_K_M";
          cmd = "\${binary} \
              -m \${models_dir}/Qwopus3.6-27B-Coder-Compat-MTP-Q5_K_M.gguf \
              -ngl 64 \
              --ctx-size 128000 \
              --no-mmproj-offload \
              --no-context-shift \
              --kv-unified \
              --spec-type draft-mtp \
              --spec-draft-n-max 6 \
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
              --presence-penalty 0.0 \
              --repeat-penalty 1.05 \
              --reasoning off \
              --chat-template-file /projects/models/qwen36-chat_template.jinja \
              --chat-template-kwargs '{\"preserve_thinking\":true}' \
              --port \${PORT}";
        };
        "Qwopus3.6-27B-Coder-MTP-Q5_K_M-think" = {
          name = "Qwopus3.6-27B-Coder-MTP-Q5_K_M-think";
          cmd = "\${binary} \
              -m \${models_dir}/Qwopus3.6-27B-Coder-Compat-MTP-Q5_K_M.gguf \
              -ngl 64 \
              --ctx-size 128000 \
              --no-mmproj-offload \
              --no-context-shift \
              --kv-unified \
              --spec-type draft-mtp \
              --spec-draft-n-max 6 \
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
              --presence-penalty 0.0 \
              --repeat-penalty 1.05 \
              --reasoning on \
              --chat-template-file /projects/models/qwen36-chat_template.jinja \
              --chat-template-kwargs '{\"preserve_thinking\":true}' \
              --port \${PORT}";
        };

        "Qwopus3.6-27B-Coder-MTP-Q6-K-think" = {
          name = "Qwopus3.6-27B-Coder-MTP-Q6_K-think";
          cmd = "\${binary} \
              -m \${models_dir}/Qwopus3.6-27B-Coder-Compat-MTP-Q6_K.gguf \
              -ngl 64 \
              --ctx-size 128000 \
              --no-mmproj-offload \
              --no-context-shift \
              --kv-unified \
              --spec-type draft-mtp \
              --spec-draft-n-max 6 \
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
              --presence-penalty 0.0 \
              --repeat-penalty 1.05 \
              --reasoning on \
              --chat-template-file /projects/models/qwen36-chat_template.jinja \
              --chat-template-kwargs '{\"preserve_thinking\":true}' \
              --port \${PORT}";
        };

        # 64 layers total for qwen36-27b
        "Qwen3.6-27B-UD-Q5_K_XL" = {
          name = "Qwen3.6-27B-UD-Q5_K_XL";
          cmd = "\${binary} \
              -m \${models_dir}/Qwen3.6-27B-UD-Q5_K_XL.gguf \
              -ngl 56 \
              --ctx-size 128000 \
              --no-mmproj-offload \
              --no-context-shift \
              --kv-unified \
              --spec-type draft-mtp \
              --spec-draft-n-max 6 \
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
              -np -1 \
              --presence-penalty 0.0 \
              --repeat-penalty 1.05 \
              --reasoning on \
              \${common_args} \
              --chat-template-file /projects/models/qwen36-chat_template.jinja \
              --chat-template-kwargs '{\"preserve_thinking\":true}' \
              --port \${PORT}";
        };
        # https://huggingface.co/unsloth/Qwen3.6-35B-A3B-MTP-GGUF
        # 40 layer
        "Qwen3.6-35B-A3B-UD-Q4_K_XL-MTP" = {
          name = "Qwen3.6-35B-A3B-UD-Q4_K_XL-MTP";
          cmd = "\${binary} \
              -m \${models_dir}/Qwen3.6-35B-A3B-UD-Q4_K_XL-MTP.gguf \
              -ngl 56 \
              --ctx-size 128000 \
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
              -np -1 \
              --port \${PORT} \
              \${common_args} \
              --presence-penalty 0.0 \
              --repeat-penalty 1.05 \
              --reasoning on";
        };
        "z-image-turbo-F16" = {
          name = "z-image-turbo-F16";
          cmd = "\${binary} \
              -m \${models_dir}/z-image-turbo-F16.gguf \
              --mmproj \${models_dir}/z-image-turbo-F16.gguf \
              --port \${PORT} \
              \${common_args} ";
        };
      };
    };
  };
}
