# Portefaix Distroless images

Container image made with [apko](https://github.com/chainguard-dev/apko) and [melange](https://github.com/chainguard-dev/melange).

## 🔑 SLSA

All _artifacts_ provided by this repository meet [SLSA L3](https://slsa.dev/spec/v1.0/levels#build-l3)

### 🏗️ Verify SLSA provenance using the Github CLI

```shell
$ gh attestation verify oci://ghcr.io/portefaix/portefaix-distroless:v1.0.0 --repo portefaix/portefaix-distroless
```

### 🏗️ Verify SLSA provenance using Cosign

```shell
$ cosign verify-attestation \
  --type slsaprovenance \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com \
  --certificate-identity-regexp '^https://github.com/slsa-framework/slsa-github-generator/.github/workflows/generator_container_slsa3.yml@refs/tags/v[0-9]+.[0-9]+.[0-9]+$' \
  ghcr.io/portefaix/portefaix-distroless:v1.0.0@sha256:xxxx
```

## OCI

You could discover all the referrers of manifest with annotations, displayed in a tree view:

```shell
$ oras discover --format tree ghcr.io/portefaix/portefaix-distroless:v1.0.0
```

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md)

## License

[Apache 2.0 License](./LICENSE)
