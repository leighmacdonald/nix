{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    profiles.default = {
      extensions =
        with pkgs.vscode-extensions;
        [
          golang.go
          jnoortheen.nix-ide
          ms-python.python
          ms-azuretools.vscode-docker
          ms-azuretools.vscode-containers
          ms-vscode-remote.remote-ssh
          # sarrus.sourcepawn-vscode
          biomejs.biome
          nefrob.vscode-just-syntax
          redhat.vscode-yaml
          #mtxr.sqltools
          christian-kohler.npm-intellisense
          #tooltitudeteam.tooltitude
          usernamehw.errorlens
          #pflannery.vscode-versionlens
          #ms-ossdata.vscode-pgsql
          #Supabase.postgrestools
          #antfu.vite
          jnoortheen.nix-ide
          #bbenoist.Nix
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "vscode-buf";
            publisher = "bufBuild";
            version = "0.8.18";
            sha256 = "sha256-DbfFZgLRkI8OnURX0f1uJIPFcCNvRKlkS9APxDn7sNE=";
          }
          # {
          #   name = "sourcepawn-vscode";
          #   publisher = "Sarrus";
          #   version = "8.1.8";
          #   sha256 = "sha256-RLL1MqrkILN4wn6B1voMgSX9QYhp5D368FuB3lGfzJA=";
          # }
        ];
      userSettings = {
        sourcepawn = {
          AuthorName = "Leigh MacDonald";
          enableLinter = true;
          GithubName = "leighmacdonald";
          availableAPIs = [
            {
              compilerArguments = [
                "-E"
                "-v2"
              ];
              compilerPath = "/home/leigh/.sm-pkg/sdks/sourcemod-1.13/addons/sourcemod/scripting/spcomp64";
              includeDirectories = [
                "/home/leigh/.sm-pkg/sdks/sourcemod-1.13/addons/sourcemod/scripting/include"
                "/projects/gbans/sourcemod/scripting/include"
              ];
              name = "1.13";
              outputDirectoryPath = "";
            }
            {
              compilerArguments = [
                "-E"
                "-v2"
              ];
              compilerPath = "/home/leigh/.sm-pkg/sdks/sourcemod-1.12/addons/sourcemod/scripting/spcomp64";
              includeDirectories = [
                "/home/leigh/.sm-pkg/sdks/sourcemod-1.12/addons/sourcemod/scripting/include"
                "/projects/gbans/sourcemod/scripting/include"
              ];
              name = "1.12";
              outputDirectoryPath = "";
            }
          ];
        };

        workbench.colorTheme = "Stylix";
        redhat.telemetry.enabled = false;
        SourcePawnLanguageServer = {
          hover.actions.enable = true;
          eventsGameName = "Team Fortress 2";
          compiler = {
            path = "/home/leigh/.sm-pkg/sdks/sourcemod-1.13/addons/sourcemod/scripting/spcomp64";
            arguments = [
              "-E"
              "-v2"
            ];
          };
          includeDirectories = [
            "/home/leigh/.sm-pkg/sdks/sourcemod-1.13/addons/sourcemod/scripting/include"
            "/projects/gbans/sourcemod/scripting/include"
          ];
          cachePriming.projectsThreshold = 0;
        };
      };
    };
  };
}
