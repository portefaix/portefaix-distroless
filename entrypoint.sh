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
(_____ \           _         / __)    (_)              kubectl:   $(kubectl version --client -o json | jq -r '.clientVersion.gitVersion')
 _____) )__   ____| |_  ____| |__ ____ _ _   _         helm:      $(helm version --template "{{.Version}}")
|  ____/ _ \ / ___)  _)/ _  )  __) _  | ( \ / )        kustomize: $(kustomize version)
| |   | |_| | |   | |_( (/ /| | ( ( | | |) X (         jq:        $(jq --version)
|_|    \___/|_|    \___)____)_|  \_||_|_(_/ \_)        yq:        $(yq --version)

Home: https://github.com/portefaix/portefaix-distroless

EOF
exec /bin/sh
