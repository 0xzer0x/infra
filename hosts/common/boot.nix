{
  boot = {
    # NOTE: GRUB bootloader
    loader = {
      efi.canTouchEfiVariables = true;

      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        gfxmodeEfi = "1920x1080,auto";
        extraGrubInstallArgs =
          [ "--efi-directory=/boot/efi" "--bootloader-id=NIX" ];
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
  };
}
