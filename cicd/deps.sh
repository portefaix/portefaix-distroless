#!/bin/bash

ARCHS="amd64 arm64"

KUBECTL_VERSION=1.27.1
HELM_VERSION=v3.11.3
# datasource=github-tags depName=kubernetes-sigs/kustomize
KUSTOMIZE_VERSION="v5.0.1"
# datasource=github-tags depName=mikefarah/yq
YQ_VERSION="v4.6.1"
# datasource=github-tags depName=instrumenta/kubeval
KUBEVAL_VERSION="0.15.0"
# datasource=github-tags depName=yannh/kubeconform
KUBECONFORM_VERSION="v0.4.12"
# datasource=github-tags depName=open-policy-agent/opa
OPA_VERSION="v0.28.0"
# datasource=github-tags depName=open-policy-agent/conftest
CONFTEST_VERSION="0.25.0"
# datasource=github-tags depName=jsonnet-bundler/jsonnet-bundler
JB_VERSION="v0.4.0"

for arch in $ARCHS; do
    echo "Download Kubectl ${arch} ..."
    curl -sL "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${arch}/kubectl" -o "kubectl-${arch}"
    
    echo "Download Helm ${arch} ..."
    curl -fsL "https://get.helm.sh/helm-${HELM_VERSION}-linux-${arch}.tar.gz" | tar xz
	mv "linux-${arch}/helm" "helm-${arch}"
	rm -rf "linux-${arch}"

    echo "Download Kustomize ${arch} ..."
    curl -fsL "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_${arch}.tar.gz" | tar xz
	mv kustomize "kustomize-${arch}"

    echo "Download Yq ${arch} ..."
    curl -sL "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_${arch}" -o yq-${arch}
    chmod +x "yq-${arch}"

    echo "Download Kubeval ${arch} ..."
    curl -sL "https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz" | tar xz
    mv kubeval "kubeval-${arch}"
    chmod +x "kubeval-${arch}"

    echo "Download Kubeconform ${arch} ..."
    curl -sL "https://github.com/yannh/kubeconform/releases/download/${KUBECONFORM_VERSION}/kubeconform-linux-amd64.tar.gz" | tar xz
    mv kubeconform "kubeconform-${arch}"
    chmod +x "kubeconform-${arch}"

    echo "Download Opa ${arch} ..."
    curl -sL "https://github.com/open-policy-agent/opa/releases/download/${OPA_VERSION}/opa_linux_amd64" -o opa-${arch}
    chmod +x "opa-${arch}"

    echo "Download Conftest ${arch} ..."
    curl -sL "https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz" | tar xz
    mv "conftest" "conftest-${arch}"
    chmod +x "conftest-${arch}"

    echo "Download Jb ${arch} ..."
    curl -sL "https://github.com/jsonnet-bundler/jsonnet-bundler/releases/download/${JB_VERSION}/jb-linux-amd64" -o jb-${arch}
    chmod +x "jb-${arch}"
done