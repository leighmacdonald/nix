{
  pkgs,
  config,
  username,
  ...
}:
{
  users = {
    mutableUsers = false;
    groups = {
      lusers.gid = 2000;
    };
    users."${username}" = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "docker"
      ];
      hashedPasswordFile = config.sops.secrets.password.path;
      uid = 2000;
      name = username;
      group = "lusers";
      createHome = true;
      #shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPX0V5t0v1XYNOmtGnMOhSZFfRKOW7OighKA+eZGcjSw 2026-leigh.macdonald@gmail.com"
        "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAyvIW5JmPEviReir7aTLGDlXPX2yaI/P3/2244OC/vdEglpmsMbrXQqxkBXUd7Oh1/4f6xF0BvKGUWuqVg5ctuf9S7DZRBBYrXz66zYKiSi6uhuVdBfOCB8+4AVGCVspeapzZ0JB0H6yy/LVrmG69Z7PZKerPw+9KLAIcX4I4COrmmkbeOfShV6Nu+MeP6P6wWXzj2UcI4qcCoHJMR9iX3o63ml1PRI/CO5ZuDnTrOY/iEcg4+pvJaqBSKo3UejzikwQ35gEKOy7WHQFj1YfTbFa7Lp91Ee+6SVhJag5zLyGqNiK/vhLjGCQ4yb+0140wtUiwOZT5ELhsycA3cICmsw=="
      ];
    };
  };

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
}
