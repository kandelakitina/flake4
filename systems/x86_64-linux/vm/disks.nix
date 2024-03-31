{
  disko.devices = {
    disk.main = {
      device = "/dev/vda";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };
          esp = {
            name = "ESP";
            size = "500M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          swap = {
            size = "4G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          root = {
            name = "root";
            size = "100%";
            content = {
              type = "lvm_pv";
              vg = "root_vg";
            };
          };
        };
      };
    };
    lvm_vg = {
      root_vg = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = ["-f"];

              subvolumes = {
                "/root" = {
                  mountpoint = "/";
                  mountOptions = ["subvol=root" "compress=zstd" "noatime"];
                };
                "/home" = {
                  mountpoint = "/home";
                  mountOptions = ["subvol=home" "compress=zstd" "noatime"];
                };
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = ["subvol=nix" "compress=zstd" "noatime"];
                };
                "/persist" = {
                  mountpoint = "/persist";
                  mountOptions = ["subvol=persist" "compress=zstd" "noatime"];
                };
                "/log" = {
                  mountpoint = "/var/log";
                  mountOptions = ["subvol=log" "compress=zstd" "noatime"];
                };
              };
            };
          };
        };
      };
    };
  };
  fileSystems."/persist".neededForBoot = true;
  fileSystems."/var/log".neededForBoot = true;

  fileSystems."/" = {
    device = "/dev/root_vg/root"; # Path to the logical volume
    fsType = "btrfs"; # File system type
    options = [ "subvol=root" "compress=zstd" "noatime" ]; # Mount options, including subvolume
  };
  swapDevices = [
    {
      device = "/dev/vda2"; # Path to the swap partition
      priority = 0; # Optional: Swap priority
    }
  ];
  
}
