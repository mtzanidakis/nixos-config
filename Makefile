.PHONY: deploy
deploy:
	nixos-rebuild switch --flake .#

.PHONY: deploy-debug
deploy-debug:
	nixos-rebuild switch --flake --show-trace .#

.PHONY: gc
gc:
	nix-collect-garbage

.PHONY: gc-all
gc-all:
	nix-collect-garbage -d

.PHONY: update
update:
	nix flake update

.PHONY: upgrade
upgrade: update deploy
