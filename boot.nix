{
  boot = {
    # NOTE: grub boot loader
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

    # NOTE: quiet boot process
    kernelParams = [ "quiet" ];

    # NOTE: screen
    plymouth = {
      enable = true;
      theme = "spinner";
    };
  };
}
