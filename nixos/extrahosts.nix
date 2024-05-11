{ config, pkgs, ... }:

{
  networking.extraHosts = ''

    # lw devsetup hosts
    127.0.0.1 api.learnworlds.develop
    127.0.0.1 account.learnworlds.develop
    127.0.0.1 analytics.learnworlds.develop
    127.0.0.1 assets.learnworlds.develop
    127.0.0.1 aurora.learnworlds.develop
    127.0.0.1 client.learnworlds.develop
    127.0.0.1 companion.learnworlds.develop
    127.0.0.1 kafka-ui.learnworlds.develop
    127.0.0.1 profiler.learnworlds.develop

    # local dev hosts
    127.0.0.1 aris.local
    127.0.0.1 proteins.local
  '';
}
