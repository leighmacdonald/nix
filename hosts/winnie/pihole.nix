#
# pi-hole.nix
#
# Notes
# - Pi-hole doesn't have a mechanism to manage Groups, Clients, or
#   Domains. Use the web gui.
#   - https://docs.pi-hole.net/group_management/example/
#
{lib, ...}: {
  networking = {
    hosts = {
      "192.168.0.200" = ["frankie.roto.lol" "frankie"];
      "192.168.0.201" = ["rupert.roto.lol" "rupert"];
      "192.168.0.210" = ["mika.roto.lol" "mika"];
      "192.168.0.211" = ["phyllis.roto.lol" "phyllis"];
      "192.168.0.212" = ["winnie.roto.lol" "winnie"];
    };
  };

  services = {
    # I'm not actually using the dnsmasq service. Pi-hole provides
    # it's own dnsmasq. I'm using Nix' ability to manage the
    # dnsmasq-style configuration file that Pi-hole utilizes.
    dnsmasq = {
      enable = false;
      settings = {
        address = [
          "/feelinsonice-hrd.appspot.com/ # Block Snapchat"
          "/feelinsonice.appspot.com/ # Block Snapchat"
          "/snapchat.com/ # Block Snapchat"
        ];
        dhcp-name-match = [
          "set:hostname-ignore,wpad"
          "set:hostname-ignore,localhost"
        ];
        # Set DHCP option 6 to the DNS server you nodes should use.
        dhcp-option = [
          "vendor:MSFT,2,1i"
          "6,192.168.0.212"
        ];
        domain = [
          "roto.lol,192.168.0.0/24,local"
        ];
      };
    };

    pihole-ftl = {
      enable = true;
      lists = [
        {
          url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
          type = "block";
          enabled = true;
          description = "Steven Black's HOSTS";
        }
      ];
      openFirewallDNS = true;
      openFirewallDHCP = true;
      openFirewallWebserver = true;
      queryLogDeleter.enable = true;
      settings = {
        dhcp = {
          active = false; # <-- SET TO TRUE ONLY WHEN YOU'RE READY!
          end = "192.168.0.254";
          hosts = [
            "04:42:1A:E8:BE:9B,192.168.0.200,frankie"
            "0C:C4:7A:B4:8D:46,192.168.0.201,rupert"
            "B8:27:EB:94:3E:4A,192.168.0.210,mika"
            "E4:5F:01:8E:67:E6,192.168.0.211,phyllis"
            "E4:5F:01:94:42:A2,192.168.0.212,winnie"
          ];
          ipv6 = false;
          leaseTime = "24h";
          start = "192.168.0.100";
          rapidCommit = true;
          resolver = {
            resolveIPv6 = false;
          };
          router = "192.168.0.1";
        };
        # misc.readOnly = false;
        dns = {
          # cnameRecords = [
          #   "color-printer,office-printer"
          #   "color-printer.homelab.me,office-printer.homelab.me"
          # ];
          domain = "roto.lol";
          domainNeeded = true;
          expandHosts = true;
          interface = "end0";
          hosts = [
            "192.168.0.1    gateway"
            "192.168.0.200  frankie"
            "192.168.0.201  rupert"
            "192.168.0.210  mika"
            "192.168.0.211  phyllis"
            "192.168.0.212  winnie"
          ];
          upstreams = ["1.1.1.1" "1.1.1.2"];
        };
        # Let's not use Pi-hole time service. My home router provides clock.
        ntp = {
          ipv4.active = false;
          ipv6.active = false;
          sync.active = false;
        };
        webserver = {
          api = {
            # To manage the web login:
            # 1) Temporarily set misc.readOnly to false in
            #    configuration.nix and switch to it.
            # 2) Manually set a password:
            #    Pi-hole web console > Settings > All settings >
            #    Webserver and API > webserver.api.password > Value: ******
            # 3) Read the generated hash:
            #    sudo pihole-FTL --config webserver.api.pwhash
            pwhash = "$BALLOON-SHA256...";
          };
          session = {
            timeout = 43200; # 12h
          };
        };
      };
      useDnsmasqConfig = true;
    };

    pihole-web = {
      enable = true;
      ports = [8180];
    };

    resolved = {
      settings = {
        Resolve = {
          DNSStubListener = false;
          MulticastDNS = false;
        };
      };
    };
  };

  #
  # System
  #
  system.activationScripts = {
    print-pi-hole = {
      text = builtins.trace "building the pi-hole configuration..." "";
    };
  };

  #
  # Systemd
  #
  # The following silences a benign FTL.log warning:
  # WARNING API: Failed to read /etc/pihole/versions (key: internal_error)
  systemd.tmpfiles.rules = [
    # Type Path Mode User Group Age Argument
    "f /etc/pihole/versions 0644 pihole pihole - -"
  ];
}
