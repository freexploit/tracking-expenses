alias b := build
alias p := build_push
alias r := run

run:
    nix run

build:
    #!/usr/bin/env bash
    nix build .#container_image

build_push:
    #!/usr/bin/env bash
    nix build .#container_image
    podman load < ./result
    podman tag localhost/tracking-expenses:latest ghcr.io/freexploit/tracking_expenses:v2
    podman push ghcr.io/freexploit/tracking_expenses:v2
