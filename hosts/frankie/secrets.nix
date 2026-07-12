{ username, ... }:
{
  sops.secrets = {
    gh_pat_general = { };
    gh_pat_tools = { };
    hf_token = { };
    opencode_env = {
      path = "/etc/opencode/envfile";
      owner = username;
    };
    llama_env = {
      path = "/etc/llama-swap/envfile";
      owner = username;
    };
  };
}
