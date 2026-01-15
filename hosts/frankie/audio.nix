{ pkgs, ... }:
{
  security.rtkit.enable = true;
  #software.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    #alsa.enable = true;
    #alsa.support32Bit = true;
    #pulse.enable = true;
    wireplumber = {
      enable = true;
      extraConfig = {
        disableBT = {
          hardware.bluetooth = false;
          monitor.bluez = false;
          wireplumber.profiles = {
            main-no-bt = {
              inherits = [ "main" ];
              hardware.bluetooth = "disabled";
            };
          };
        };
      };
      configPackages = [
        (pkgs.writeTextDir "share/wireplumber/main.lua.d/99-alsa-lowlatency.lua" ''
          	          alsa_monitor.rules = {
            	        {
          	          matches = {{{ "node.name", "matches", "alsa_output.usb-Schiit_Audio_Schiit_Bifrost_2_Unison_USB-00.analog-stereo" }}};
          	          apply_properties = {
          	            ["audio.format"] = "S32LE",
          	            ["audio.rate"] = "192000", -- for USB soundcards it should be twice your desired rate
          	            ["api.alsa.period-size"] = 2, -- defaults to 1024, tweak by trial-and-error
          	            -- ["api.alsa.disable-batch"] = true, -- generally, USB soundcards use the batch mode
          	          },
          	        },
          	      }
          	    '')
      ];
    };
    extraConfig = {
      pipewire."99-silent-bell.conf" = {
        "context.properties" = {
          "module.x11.bell" = false;
        };
      };
      pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.allowed-rates" = [
            44100
            88200
            176400
            48000
            96000
            192000
          ];
          "default.clock.rate" = 192000;
          "default.clock.quantum" = 300;
          "default.clock.min-quantum" = 200;
          "default.clock.max-quantum" = 1024;
        };
        "stream.properties" = {
          "resample.quality" = 14;
        };
      };
      # pipewire."92-low-latency" = ""
      #   "context.properties" = {
      #     "default.clock.rate" = 48000;
      #     "default.clock.quantum" = 32;
      #     "default.clock.min-quantum" = 32;
      #     "default.clock.max-quantum" = 32;
      #   };
      # };
      # pipewire-pulse."92-low-latency" = {
      #   "context.properties" = [
      #     {
      #       name = "libpipewire-module-protocol-pulse";
      #       args = { };
      #     }
      #   ];
      #   "pulse.properties" = {
      #     "pulse.min.req" = "200/192000";
      #     "pulse.default.req" = "300/192000";
      #     "pulse.max.req" = "1024/192000";
      #     "pulse.min.quantum" = "200/192000";
      #     "pulse.max.quantum" = "1024/192000";
      #   };
      #   "stream.properties" = {
      #     "node.latency" = "32/48000";
      #     "resample.quality" = 1;
      #   };
      # };
    };
  };
}
