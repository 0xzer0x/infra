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

    # NOTE: Quiet boot process
    kernelParams = [ "quiet" ];

    # NOTE: Bootloader screen
    plymouth = {
      enable = true;
      theme = "spinner";
    };
  };
}
