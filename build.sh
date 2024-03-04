#!/usr/bin/env bash

#    Conftest - Write tests against your config files
#
#    Copyright (C) 2019 Gareth Rushgrove
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        https://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

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

ARCH=$(uname -m)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

source "${SCRIPT_DIR}/hack/scripts/commons.sh"

# echo_info "[portefaix-distroless] Download dependencies"
# rm -fr packages
# ${SCRIPT_DIR}/deps.sh

echo_info "[portefaix-distroless] Generate temporary key"
test -f melange.rsa || docker run --rm -it --privileged \
    -v "${PWD}:/work" -w /work \
    cgr.dev/chainguard/melange keygen

echo_info "[portefaix-distroless] Build the APK"
docker run --privileged --rm -v "${PWD}:/work" -w /work \
    cgr.dev/chainguard/melange build melange.yaml --arch "${ARCH}" --signing-key melange.rsa

echo_info "[portefaix-distroless] Building the Container Image"
docker run --rm -v "${PWD}:/work" -w /work \
    cgr.dev/chainguard/apko build apko.yaml portefaix-distroless:dev portefaix-distroless.tar --arch "${ARCH}" -k melange.rsa.pub

echo_info "[portefaix-distroless] Load image"
docker load <portefaix-distroless.tar
