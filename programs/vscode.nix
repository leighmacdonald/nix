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
          ms-python.vscode-pylance
          ms-python.debugpy
          ms-azuretools.vscode-docker
          ms-azuretools.vscode-containers
          ms-vscode-remote.remote-ssh
          biomejs.biome
          nefrob.vscode-just-syntax
          redhat.vscode-yaml
          redhat.ansible
          vadimcn.vscode-lldb
          rust-lang.rust-analyzer
          christian-kohler.npm-intellisense
          usernamehw.errorlens
          jnoortheen.nix-ide
          firefox-devtools.vscode-firefox-debug
          davidanson.vscode-markdownlint
          #eamodio.gitlens
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "go-testing-plus";
            publisher = "sergiobonfiglio";
            version = "0.4.1";
            sha256 = "sha256-Ipyy8BCI8Zpjpr0pN6zHbAihCpCvBVcesGailMHVQBw=";
          }
          {
            name = "exp-vscode-go";
            publisher = "ethan-reesor";
            version = "0.2.3";
            sha256 = "sha256-U9ypBWc+BnZKaSspDcABr7tWfEHyynoVjShkzgGzaKo=";
          }
          {
            name = "vscode-buf";
            publisher = "bufBuild";
            version = "0.8.18";
            sha256 = "sha256-DbfFZgLRkI8OnURX0f1uJIPFcCNvRKlkS9APxDn7sNE=";
          }
          {
            name = "vscode-jetbrains-keybindings";
            publisher = "isudox";
            version = "0.1.9";
            sha256 = "sha256-Y+g6eNp4aRqVisyp+LqtN/iSZ6fzkVTFCLPTE3KoYDk=";
          }
          {
            name = "sqltools";
            publisher = "mtxr";
            version = "0.28.5";
            sha256 = "sha256-2JgBRMaNU3einOZ0POfcc887HCScu6myETTLoJMS6o8=";
          }
          {
            name = "sqltools-driver-pg";
            publisher = "mtxr";
            version = "0.5.7";
            sha256 = "sha256-fbQsKnkBz11ZTZ2v7Y9bQ9GHPjactUoB98LeNRKeOkY=";
          }
          {
            name = "tooltitude";
            publisher = "tooltitudeteam";
            version = "1.50.5";
            sha256 = "sha256-PwdlLP2hqPD6E2wCAAvgmgBSg0XFOpB+DL/PfkmoZn4=";
          }
          {
            name = "vscode-versionlens";
            publisher = "pflannery";
            version = "1.28.0";
            sha256 = "sha256-IZjTHE51hdrQpDndsz5bBCKre0zmWkCAJa/v8k4iLy0=";
          }
          {
            name = "continue";
            publisher = "Continue";
            version = "1.2.22";
            sha256 = "sha256-5OFxXWASzwdNzGm8riwc77y5C0V05qelMxOGkizBsyg=";
          }
          #         {
          #            name = "vscode-pgsql";
          #            publisher = "ms-ossdata";
          #            version = "1.21.1";
          #            sha256 = "sha256-7sarLDiT0dgrI0g4RAvZ9t/V1OEBS/SEPAmnAmADhsU=";
          #          }
          # {
          #   name = "postgrestools";
          #   publisher = "Supabase";
          #   version = " 	1.4.0";
          #   sha256 = "sha256-DbfFZgLRkI8OnURX0f1uJIPFcCNvRKlkS9APxDn7sNE=";
          # }
          # {
          #   name = "sourcepawn-vscode";
          #   publisher = "Sarrus";
          #   version = "8.1.8";
          #   sha256 = "sha256-RLL1MqrkILN4wn6B1voMgSX9QYhp5D368FuB3lGfzJA=";
          # }
        ];
      userSettings = {
        goExp.testExplorer.enable = true;
        github.copilot.enable = {
          "*" = false;
        };
        editor.formatOnPaste = true;
        editor.formatOnSave = true;
        files.autoSave = "afterDelay";
        editor.minimap.enabled = false;
        sourcepawn.AuthorName = "Leigh MacDonald";
        sourcepawn.enableLinter = true;
        sourcepawn.GithubName = "leighmacdonald";
        sourcepawn.availableAPIs = [
          {
            compilerArguments = [
              #              "-E"
              "-v2"
              "-w203"
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
              #             "-E"
              "-v2"
              "-w203"
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

        # workbench.colorTheme = "Stylix";
        workbench.colorTheme = "Abyss";
        editor.autoIndentOnPaste = true;
        editor.bracketPairColorization.independentColorPoolPerBracketType = true;
        # editor.experimentalGpuAcceleration = "";
        redhat.telemetry.enabled = false;
        SourcePawnLanguageServer.hover.actions.enable = true;
        SourcePawnLanguageServer.hover.actions.references.enable = true;
        SourcePawnLanguageServer.eventsGameName = "Team Fortress 2";
        SourcePawnLanguageServer.compiler = {
          path = "/home/leigh/.sm-pkg/sdks/sourcemod-1.13/addons/sourcemod/scripting/spcomp64";
          arguments = [
            #           "-E"
            "-v2"
            "-w203"
          ];
        };
        SourcePawnLanguageServer.includeDirectories = [
          "/home/leigh/.sm-pkg/sdks/sourcemod-1.13/addons/sourcemod/scripting/include"
          "/projects/gbans/sourcemod/scripting/include"
        ];
        SourcePawnLanguageServer.cachePriming.projectsThreshold = 0;
      };
    };
  };
}
