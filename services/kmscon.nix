{ username, ... }:
{
  services.kmscon = {
    enable = true;
    #hwRender = true; # lol. Though doesnt work with nvidia binary driver.
    autologinUser = username;
  };
}
