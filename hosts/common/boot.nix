{
  boot = {
    # NOTE: Bootloader
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      systemd-boot = {
        enable = true;
        edk2-uefi-shell.enable = true;
        configurationLimit = 100;
        consoleMode = "max";
      };
    };

    # NOTE: Silent boot process
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];

    # NOTE: Bootloader screen
    plymouth = {
      enable = true;
      theme = "spinner";
    };

    # NOTE: Cleanup for /tmp
    tmp.cleanOnBoot = true;
  };
}
