{ config, ... }:
{
  sops.secrets = {
    gh_pat_general = { };
    gh_pat_tools = { };
    hf_token = { };
  };

  environment.variables = {
    GITHUB_TOKEN = config.sops.secrets.gh_pat_general.path;
    GITHUB_TOKEN_TOOLS = config.sops.secrets.gh_pat_tools.path;
  };
}
