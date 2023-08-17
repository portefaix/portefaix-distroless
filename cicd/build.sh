#!/usr/bin/env bash

set -feu -o pipefail

reset_color="\\e[0m"
color_red="\\e[31m"
color_green="\\e[32m"
color_blue="\\e[36m"

ARCH=$(uname -m)

function echo_fail { echo -e "${color_red}✖ $*${reset_color}"; }
function echo_success { echo -e "${color_green}✔ $*${reset_color}"; }
function echo_info { echo -e "${color_blue}\uf120 $*${reset_color}"; }

rm -fr packages

echo_info "[portefaix-distroless] Generate temporary key"
test -f melange.rsa || docker run --rm -it --privileged \
    -v "$(pwd):/work" -w /work \
    cgr.dev/chainguard/melange keygen

echo_info "[portefaix-distroless] Build the APK"
docker run --privileged --rm -v "$(pwd):/work" \
  cgr.dev/chainguard/melange build melange.yaml --arch "${ARCH}" --signing-key melange.rsa

echo_info "[portefaix-distroless] Building the Container Image"
docker run --rm -v "$(pwd):/work" \
    cgr.dev/chainguard/apko build apko.yaml portefaix-cicd:test portefaix-cicd.tar --arch "${ARCH}" -k melange.rsa.pub
    
echo_info "[portefaix-distroless] Load image"
docker load < portefaix-cicd.tar
