.PHONY: update
update:
	nix flake update

.PHONY: deploy
deploy:
	nixos-rebuild switch --flake .#

.PHONY: deploy-debug
deploy-debug:
	nixos-rebuild switch --flake --show-trace .#

.PHONY: upgrade
upgrade: update deploy
