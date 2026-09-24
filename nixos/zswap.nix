{
  # zswap compresses in RAM in front of a disk swapfile; unlike zram, the
  # swapfile can also hold the hibernation image. Each host declares the
  # swapfile itself in hardware-configuration.nix.
  boot.zswap.enable = true;

  boot.kernel.sysctl."vm.swappiness" = 100;
}
