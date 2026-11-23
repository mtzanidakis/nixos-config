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

.PHONY: build-debug
build-debug:
	nixos-rebuild build --show-trace --flake .#

.PHONY: diff
diff:
	nvd diff /run/current-system result

.PHONY: deploy
deploy:
	nixos-rebuild switch --flake .#

.PHONY: deploy-boot
deploy-boot:
	nixos-rebuild boot --flake .#

.PHONY: gc
gc: | $(result_dir)
	nix-collect-garbage

.PHONY: gc-old
gc-old: | $(result_dir)
	nix-collect-garbage -d

.PHONY: ls-updates
ls-updates: update build diff

# gizu updates almost daily and hits the anonymous GitHub API rate limit,
# so authenticate there; the other hosts update rarely and have no gh.
ifeq ($(shell uname -n),gizu)
update: export NIX_CONFIG = access-tokens = github.com=$(shell gh auth token)
endif

.PHONY: update
update:
	nix flake update $(INPUTS)

.PHONY: upgrade
upgrade: update deploy
