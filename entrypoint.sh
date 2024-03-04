#!/bin/bash

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

[ -n "$1" ] && exec "$@"

cat <<EOF

 ______                       ___      _
(_____ \           _         / __)    (_)              kubectl: ${KUBECTL_VERSION}
 _____) )__   ____| |_  ____| |__ ____ _ _   _         helm: ${HELM_VERSION}
|  ____/ _ \ / ___)  _)/ _  )  __) _  | ( \ / )        kustomize: ${KUSTOMIZE_VERSION}
| |   | |_| | |   | |_( (/ /| | ( ( | | |) X (
|_|    \___/|_|    \___)____)_|  \_||_|_(_/ \_)

Home: https://github.com/portefaix/portefaix-distroless

EOF
exec /bin/sh
