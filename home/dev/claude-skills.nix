# Not a module: the skills linked into every Claude config dir, keyed by the
# directory name they get under `skills/`. Shared by ai.nix and claude-work.nix.
inputs: {
  find-skills = "${inputs.skills-vercel}/skills/find-skills";
  github-make-release = "${inputs.skills-mtzanidakis}/skills/github/github-make-release";
  github-merge-prs = "${inputs.skills-mtzanidakis}/skills/github/github-merge-prs";
}
