result_dir = $(wildcard result)

# delete the result directory if it exists
.PHONY: $(result_dir)
$(result_dir):
	rm -rf -- $(result_dir)

.PHONY: all
all: upgrade

.PHONY: build
build:
	nixos-rebuild build --flake .#

.PHONY: deploy-debug
build-debug:
	nixos-rebuild build --flake --show-trace .#

.PHONY: deploy
deploy:
	nixos-rebuild switch --flake .#

.PHONY: gc
gc: | $(result_dir)
	nix-collect-garbage

.PHONY: gc-old
gc-old: | $(result_dir)
	nix-collect-garbage -d

.PHONY: ls-updates
ls-updates: update build
	nvd diff /run/current-system result

.PHONY: update
update:
	nix flake update

.PHONY: upgrade
upgrade: update deploy
