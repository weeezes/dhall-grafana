# Local development

# Usage

Run `nix-shell` in the [`local-dev`](./local-dev) directory. After the shell has started run `foreman start` to start Grafana and other services (check [`Procfile'](./Procfile) for details), and `./watch.sh <path-to-your-dhall-dashboard>` to start the live reloads.

# Requirements

All requirements are handled by nix, check [`./shell.nix`](./shell.nix) for full list.
