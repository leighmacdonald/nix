{ username, pkgs, ... }:
let
  port = 5432;
in
{
  networking.firewall.allowedTCPPorts = [ port ];
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_18;
    ensureDatabases = [
      "sonarr-main"
      "sonarr-log"
      "lidarr-main"
      "lidarr-log"
      "radarr-main"
      "radarr-log"
      "prowlarr-main"
      "prowlarr-log"
      "tf-api"
      "gbans"
    ];
    enableTCPIP = true;

    enableJIT = true;
    extensions =
      ps: with ps; [
        postgis
        rum
        ip4r
      ];
    settings = {
      port = port;
    };
    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser origin-address auth-method
      local all      all     trust

      # ipv4
      host  all      all     127.0.0.1/32   trust
      # ipv6
      host  all      all     ::1/128        trust

      host  all      all     127.0.0.1/32 scram-sha-256
      host  all      all     ::1/128 scram-sha-256
      host  all      all     192.168.0.0/24 scram-sha-256
    '';
    initialScript = pkgs.writeText "init-sql-script" ''
      ALTER USER leigh with password 'SCRAM-SHA-256$4096:zm14gDYpIUtKLhhH3UYl2w==$jwUgiaoHmQH/U9qzGqTuFSCIEdFEpUR55N1HcAiq1Cg=:XPWj4dmi4TFhZsWaANMv2O10TkcicjyZ9mMo5ZDctks=';
      ALTER USER gbans with password 'SCRAM-SHA-256$4096:+dqKFDBNW39QOyPR6UFqkQ==$xtpWOAPArQ1CibwAHm1iH9jJhKnW1aNYukaXi5DjtuI=:X44msfKEkjEcZMVqSr9gppUYWJfEmNgf5WahU/j0exQ=';

      ALTER USER sonarr with password 'SCRAM-SHA-256$4096:OPzlh38dsk3T6FEYEQ7Z0w==$KtS41tLE2t8OGlziy4RosCTbI91D3y03p3x6c6NDKFY=:EpLmLm+Q7+CD73jdK1x3GFDlMgLvv9Wqpgxg9pzlPmc=';
      ALTER DATABASE "sonarr-log" OWNER TO sonarr;
      ALTER DATABASE "sonarr-main" OWNER TO sonarr;
      GRANT ALL ON DATABASE "sonarr-log" TO sonarr;
      GRANT ALL ON DATABASE "sonarr-main" TO sonarr;

      ALTER USER lidarr with password 'SCRAM-SHA-256$4096:uQGEn8HJQmHh7ts2H70b7w==$YAUe5aOL1hmyBFrk8PZklwkPVsNSh+8N2bkEjLLnJG4=:zRiusj6w6zsl2O7z5NA1wXOBJHYK3ycNA/VE247IRYU=';
      ALTER DATABASE "lidarr-log" OWNER TO lidarr;
      ALTER DATABASE "lidarr-main" OWNER TO lidarr;
      GRANT ALL ON DATABASE "lidarr-log" TO lidarr;
      GRANT ALL ON DATABASE "lidarr-main" TO lidarr;

      ALTER USER radarr with password 'SCRAM-SHA-256$4096:SOYjTjAkwsQ42I1v2oQiIA==$TSSIGrO/gdnOqzzdGF+o8ETU+nZ31KF+CW00QldvEtk=:rft2mOFjicFps1+Z0HLXT6Nh0NI1y4aILJ+xLXejmYA=';
      ALTER DATABASE "radarr-log" OWNER TO radarr;
      ALTER DATABASE "radarr-main" OWNER TO radarr;
      GRANT ALL ON DATABASE "radarr-log" TO radarr;
      GRANT ALL ON DATABASE "radarr-main" TO radarr;

      ALTER USER prowlarr with password 'SCRAM-SHA-256$4096:GMmLBQPSXQlWPjjc0nvHGw==$bXxm7NfnDKha9Jd3wmPsoZzXXABQElsdcRYzh+lJu7o=:qBLv9bPgF19OmI5UAufcmi+9poHiCtpO6+h9SwoawSA=';
      ALTER DATABASE "prowlarr-log" OWNER TO prowlarr;
      ALTER DATABASE "prowlarr-main" OWNER TO prowlarr;
      GRANT ALL ON DATABASE "prowlarr-log" TO prowlarr;
      GRANT ALL ON DATABASE "prowlarr-main" TO prowlarr;

      ALTER USER "tf-api" with password 'SCRAM-SHA-256$4096:L/jfh/HG9sjOhj6qwnywJg==$1RWkuUA5E6Z33lz3bCAdHonWOsBG8Jte+4DSFdRapUg=:BHyfCmOJx2dlJZ4Ol43ROxJ0NyMj/RoNDBFulEylbZk=';
    '';
    ensureUsers = [
      {
        name = username;
        ensureDBOwnership = false;
        ensureClauses = {
          login = true;
          superuser = true;
          createrole = true;
          createdb = true;
        };
      }
      {
        name = "sonarr";
        ensureClauses = {
          login = true;
        };
      }
      {
        name = "radarr";
        ensureClauses = {
          login = true;
        };
      }
      {
        name = "lidarr";
        ensureClauses = {
          login = true;
        };
      }
      {
        name = "prowlarr";
        ensureClauses = {
          login = true;
        };
      }
      {
        name = "tf-api";
        ensureDBOwnership = true;
        ensureClauses = {
          login = true;
        };
      }
      {
        name = "gbans";
        ensureDBOwnership = true;
        ensureClauses = {
          login = true;
          createdb = true;
        };
      }
    ];
  };
}
