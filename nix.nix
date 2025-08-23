{
  nix = {
    settings = {
      min-free = 32212254720;
      use-xdg-base-directories = true;
      experimental-features = [ "nix-command" "flakes" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 15d";
    };
  };

  nixpkgs.config = { allowUnfree = true; };
}
