{
  hardware = {
    enableRedistributableFirmware = true;
    raspberry-pi."4".fkms-3d.enable = true;
    raspberry-pi."4".apply-overlays-dtmerge.enable = true;
    deviceTree = {
      enable = true;
      overlays = [
        {
          name = "disable-bt";
          filter = "*rpi-4-b*";
          dtsText = ''
            /dts-v1/;
            /plugin/;
            /{
                compatible = "raspberrypi,4-model-b";
                fragment@0 {
                    target = <&bt>;
                    __overlay__ {
                        status = "disabled";
                    };
                };
            };
          '';
        }
        {
          name = "disable-eth-leds";
          filter = "*rpi-4-b*";
          dtsText = ''
            /dts-v1/;
            /plugin/;
            /{
               compatible = "raspberrypi,4-model-b";
               fragment@0 {
                    target = <&phy1>;
                    __overlay__ {
                        led-modes = <0x04 0x04>;
                    };
                };
            };
          '';
        }
      ];
    };
  };
}
