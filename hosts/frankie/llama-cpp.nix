{ pkgsUnstable, lib, ... }:
{
  hardware.nvidia-container-toolkit.enable = lib.mkForce true;
  environment = {
    systemPackages = [
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

  services.llama-swap = {
    port = 8080;
    enable = true;
    package = pkgsUnstable.llama-swap;
    openFirewall = true;

    settings = {
      globalTTL = 1800;
      macros = {
        models_dir = "/projects/llm/models";
        binary = "${pkgsUnstable.llama-cpp}/bin/llama-server";
      };

      # podman run --device nvidia.com/gpu=all -d -v llama_qwen3.6mpt:/root/.cache -p 8080:8080 local/llama.cpp:full-cuda --server \
      # -hf unsloth/Qwen3.6-27B-MTP-GGUF:UD-Q4_K_XL \
      # -ngl 99 \
      # --ctx-size 128000 \
      # --no-mmproj-offload \
      # --no-context-shift \
      # --kv-unified \
      # --spec-type draft-mtp \
      # --spec-draft-n-max 2 \
      # --spec-draft-p-min 0.75 \
      # -fa on --jinja --no-mmap \
      # --cache-ram -1 \
      # --no-warmup -np 1\
      # -n 32768 \
      # --cache-type-k q8_0 \
      # --cache-type-v q8_0 \
      # --temp 0.6 \
      # --min-p 0.00 \
      # --top-k 20 \
      # --top-p 0.95 \
      # --presence-penalty 0.0 \
      # --repeat-penalty 1.05 \
      # --fit off \
      # --reasoning on \
      # --chat-template-kwargs '{"preserve_thinking":true}' \
      # --port 8080 \
      # --host 0.0.0.0
      models = {
        "GLM-4.7-Flash-REAP-23B-A3B-UD-Q3_K_XL" = {
          name = "GLM-4.7-Flash-REAP-23B-A3B-UD-Q3_K_XL";
          cmd = "\${binary} --jinja --port \${PORT}  --repeat-penalty 1.0 --min-p 0.01 --temp 1.0 --top-p 0.95 --model \${models_dir}/GLM-4.7-Flash-REAP-23B-A3B-UD-Q3_K_XL.gguf";
        };

        "GLM-4.7-Flash-REAP-23B-A3B-Q4_K_M" = {
          name = "GLM-4.7-Flash-REAP-23B-A3B-Q4_K_M";
          cmd = "\${binary} --jinja --port \${PORT}  --repeat-penalty 1.0 --min-p 0.01 --temp 1.0 --top-p 0.95 --model \${models_dir}/GLM-4.7-Flash-REAP-23B-A3B-Q4_K_M.gguf";
        };
        "GLM-4.7-Flash-REAP-23B-A3B-UD-Q4_K_XL" = {
          name = "GLM-4.7-Flash-REAP-23B-A3B-UD-Q4_K_XL";
          cmd = "\${binary} --jinja --port \${PORT}  --repeat-penalty 1.0 --min-p 0.01 --temp 1.0 --top-p 0.95 --model \${models_dir}/GLM-4.7-Flash-REAP-23B-A3B-UD-Q4_K_XL.gguf";
        };
        flux2-klein-9b-uncensored-f16 = {
          name = "flux2-klein-9b-uncensored-f16";
          cmd = "\${binary} --port \${PORT} --model \${models_dir}/flux2-klein-9b-uncensored-f16.gguf";
        };

        supergemma4-26b = {
          name = "supergemma4-26b";
          cmd = "\${binary} --port \${PORT} --model \${models_dir}/supergemma4-26b-uncensored-fast-v2-Q4_K_M.gguf";
        };

        "nomic-embed-text-2.0" = {
          name = "nomic-embed-text-2.0";
          cmd = "\${binary} --embeddings --port \${PORT} --model \${models_dir}/nomic-embed-text-v2-moe.f32.gguf";
        };

        "Qwen3.5-9B-DeepSeek-V4-Flash-Q8_0" = {
          name = "Qwen3.5-9B-DeepSeek-V4-Flash-Q8_0";
          cmd = "\${binary}  --temperature 0.7 --top-k 20 --top-p 0.95 --port \${PORT} --ctx-size 32768  --embeddings --model \${models_dir}/Qwen3.5-9B-DeepSeek-V4-Flash-Q8_0.gguf";
        };

        "Qwen3.5-9B-DeepSeek-V4-Flash-D-IQ4_NL" = {
          name = "Qwen3.5-9B-DeepSeek-V4-Flash-D-IQ4_NL";
          cmd = "\${binary} --jinja --flash-attn on --temperature 0.7 --top-k 20 --top-p 0.9 --presence-penalty 0.0 --repeat-penalty 1.0 --port \${PORT} --ctx-size 32768  --embeddings --model \${models_dir}/Qwen3.5-9B-DeepSeek-V4-Flash-D-IQ4_NL.gguf";
        };

        "GLM-4.7-Flash-Q4_K_M-general" = {
          name = "GLM-4.7-Flash-Q4_K_M-general";
          cmd = "\${binary} --fit on --temperature 1.0 --top-p 0.95 --min-p 0.01 --repeat-penalty 1.0 --port \${PORT} --ctx-size 32768  --embeddings --model \${models_dir}/GLM-4.7-Flash-Q4_K_M.gguf";
        };

        "GLM-4.7-Flash-Q4_K_M-tool" = {
          name = "GLM-4.7-Flash-Q4_K_M-tool";
          cmd = "\${binary} --fit on --temperature 0.7 --top-p 1.0 --min-p 0.01  --repeat-penalty 1.0 --port \${PORT} --ctx-size 32768 --embeddings --model \${models_dir}/GLM-4.7-Flash-Q4_K_M.gguf";
        };

        # qwen3-coder-Q3 = {
        #   name = "qwen3-coder-Q3";
        #   cmd = "\${binary} --temperature 0.7 --top-k 20 --top-p 0.8 --min-p 0.0 --presence-penalty 0.0 --repeat-penalty 1.05 --port \${PORT} --ctx-size 262144 --embeddings --model \${models_dir}/Qwen3-Coder-30B-A3B-Instruct-UD-Q3_K_XL.gguf";
        # };

        # qwen3-coder-Q4 = {
        #   name = "qwen3-coder-Q4";
        #   cmd = "\${binary} --no-mmap --temperature 0.7 --top-k 20 --top-p 0.8 --min-p 0.0 --presence-penalty 0.0 --repeat-penalty 1.05 --port \${PORT} --ctx-size 262144 --batch-size 4096 --ubatch-size 4096 --model \${models_dir}/Qwen3-Coder-30B-A3B-Instruct-UD-Q4_K_XL.gguf";
        # };

        # qwen3-coder-1M = {
        #   name = "qwen3-coder-1M";
        #   cmd = "\${binary} -ngl 10 --cache-type-k q8_0 --cache-type-v q8_0 --temperature 0.7 --top-k 20 --top-p 0.8 --min-p 0.0 --presence-penalty 0.0 --repeat-penalty 1.05 --port \${PORT} --ctx-size 1048576 --batch-size 4096 --ubatch-size 4096 --model \${models_dir}/Qwen3-Coder-30B-A3B-Instruct-1M-UD-Q4_K_XL.gguf";
        # };

        "qwen36-35B-claude-4.6" = {
          name = "qwen36-35B-claude-4.6";
          cmd = "\${binary} --no-mmap --ctx-size 262144  --temperature 0.6 --top-k 20 --top-p 0.95 --min-p 0.0 --presence-penalty 0.0 --repeat-penalty 1.0 --port \${PORT} --embeddings --model \${models_dir}/Qwen3.6-35B-A3B-Claude-4.6-Opus-Reasoning-Distilled.Q4_K_M.gguf";
        };

        qwen36-27B-Q5_k_XL = {
          name = "qwen36-27B-Q5_k_XL";
          cmd = "\${binary} --chat-template-kwargs '{\"enable_thinking\":false}' --temperature 1.0 --top-k 20 --top-p 0.95 --min-p 0.0 --presence-penalty 1.5 --repeat-penalty 1.0 --port \${PORT} --embeddings --model \${models_dir}/Qwen3.6-27B-UD-Q5_K_XL.gguf";
        };

        qwen36-27B-Q5_k_XL-thinking = {
          name = "qwen36-27B-Q5_k_XL-thinking";
          cmd = "\${binary} --temperature 1.0 --top-k 20 --top-p 0.95 --min-p 0.0 --presence-penalty 1.5 --repeat-penalty 1.0 --port \${PORT}   --embeddings --model \${models_dir}/Qwen3.6-27B-UD-Q5_K_XL.gguf";
        };

        gemma-4-it-obliterated = {
          name = "gemma-4-it-obliterated";
          cmd = "\${binary} --port \${PORT} --model \${models_dir}/gemma-4-E4B-it-OBLITERATED-Q8_0.gguf";
        };

        nemotron-3-nano = {
          name = "nemotron-3-nano";
          cmd = "\${binary} --port \${PORT} --model \${models_dir}/Nemotron-3-Nano-30B-A3B-UD-Q4_K_XL.gguf";
        };

        deepseek-r1-distill-qwen-14b = {
          name = "deepseek-r1-distill-qwen-14b";
          cmd = "\${binary} --port \${PORT} --model \${models_dir}/DeepSeek-R1-Distill-Qwen-14B-Q8_0.gguf";
        };
      };
    };
  };
}
