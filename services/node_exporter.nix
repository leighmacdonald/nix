{
  networking.firewall.allowedTCPPorts = [ 9100 ];
  services.prometheus = {
    exporters = {
      node = {
        enable = true;
        port = 9100;
        enabledCollectors = [
          "cgroups"
          "conntrack"
          "cpu"
          "cpu_vulnerabilities"
          "cpufreq"
          "diskstats"
          "dmi"
          "filesystem"
          "hwmon"
          "loadavg"
          "mountstats"
          "nfs"
          "nvme"
          "os"
          "pressure"
          "processes"
          "sockstat"
          "stat"
          "swap"
          "sysctl"
          "systemd"
          "thermal_zone"
          "time"
          "timex"
          "watchdog"
        ];
      };
    };
  };
}
