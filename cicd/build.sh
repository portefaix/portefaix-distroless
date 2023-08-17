#!/usr/bin/env bash

# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

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
docker load <portefaix-cicd.tar
