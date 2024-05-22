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

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "${SCRIPT_DIR}/hack/scripts/commons.sh"

# datasource=github-tags depName=github.com/kubernetes/kubectl
KUBECTL_VERSION="1.30.1"
# datasource=github-tags depName=github.com/helm/helm
HELM_VERSION="v3.11.3"
# datasource=github-tags depName=kubernetes-sigs/kustomize
KUSTOMIZE_VERSION="v5.0.1"
# datasource=github-tags depName=jqlang/jq
JQ_VERSION="1.7.1"
# datasource=github-tags depName=mikefarah/yq
YQ_VERSION="v4.6.1"
# datasource=github-tags depName=instrumenta/kubeval
# KUBEVAL_VERSION="0.15.0"
# datasource=github-tags depName=yannh/kubeconform
# KUBECONFORM_VERSION="v0.4.12"
# datasource=github-tags depName=open-policy-agent/opa
# OPA_VERSION="v0.28.0"
# datasource=github-tags depName=open-policy-agent/conftest
# CONFTEST_VERSION="0.25.0"
# datasource=github-tags depName=jsonnet-bundler/jsonnet-bundler
JB_VERSION="v0.4.0"

ARCHS="amd64 arm64"

DEPS="deps"
rm -fr ${DEPS} && mkdir -p ${DEPS}

for arch in $ARCHS; do
    echo_info "[portefaix-distroless] Download Kubectl ${arch} ..."
    curl -sL "https://dl.k8s.io/v${KUBECTL_VERSION}/bin/linux/${arch}/kubectl" -o "${DEPS}/kubectl-${arch}"

    echo_info "[portefaix-distroless] Download Helm ${arch} ..."
    curl -fsL "https://get.helm.sh/helm-${HELM_VERSION}-linux-${arch}.tar.gz" | tar xz
    mv "linux-${arch}/helm" "${DEPS}/helm-${arch}"
    rm -rf "linux-${arch}"

    echo_info "[portefaix-distroless] Download Kustomize ${arch} ..."
    curl -fsL "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_${arch}.tar.gz" | tar xz
    mv kustomize "${DEPS}/kustomize-${arch}"

    curl -sL "https://github.com/jqlang/jq/releases/download/jq-${JQ_VERSION}/jq-linux-${arch}" -o "${DEPS}/jq-${arch}"
    chmod +x "${DEPS}/jq-${arch}"

    echo_info "[portefaix-distroless] Download Yq ${arch} ..."
    curl -sL "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_${arch}" -o "${DEPS}/yq-${arch}"
    chmod +x "${DEPS}/yq-${arch}"

    # echo_info "[portefaix-distroless] Download Kubeval ${arch} ..."
    # curl -sL "https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz" | tar xz
    # mv kubeval "kubeval-${arch}"
    # chmod +x "kubeval-${arch}"

    # echo_info "[portefaix-distroless] Download Kubeconform ${arch} ..."
    # curl -sL "https://github.com/yannh/kubeconform/releases/download/${KUBECONFORM_VERSION}/kubeconform-linux-amd64.tar.gz" | tar xz
    # mv kubeconform "kubeconform-${arch}"
    # chmod +x "kubeconform-${arch}"

    # echo_info "[portefaix-distroless] Download Opa ${arch} ..."
    # curl -sL "https://github.com/open-policy-agent/opa/releases/download/${OPA_VERSION}/opa_linux_amd64" -o "opa-${arch}"
    # chmod +x "opa-${arch}"

    # echo_info "[portefaix-distroless] Download Conftest ${arch} ..."
    # curl -sL "https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz" | tar xz
    # mv "conftest" "conftest-${arch}"
    # chmod +x "conftest-${arch}"

    echo_info "[portefaix-distroless] Download Jb ${arch} ..."
    curl -sL "https://github.com/jsonnet-bundler/jsonnet-bundler/releases/download/${JB_VERSION}/jb-linux-amd64" -o "${DEPS}/jb-${arch}"
    chmod +x "${DEPS}/jb-${arch}"
done
