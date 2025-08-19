# Portefaix Distroless images

Container image made with [apko](https://github.com/chainguard-dev/apko) and [melange](https://github.com/chainguard-dev/melange).

## 🔑 SLSA

All _artifacts_ provided by this repository meet [SLSA L3](https://slsa.dev/spec/v1.0/levels#build-l3)

### 🏗️ Verify SLSA provenance using the Github CLI

```shell
$ gh attestation verify oci://ghcr.io/portefaix/portefaix-distroless:v0.0.5 --repo portefaix/portefaix-distroless
Loaded digest sha256:89cd1639fe77ab2436f9e69021195951203903e2e6eb012428e6cab80e857f73 for oci://ghcr.io/portefaix/portefaix-distroless:v0.0.5
Loaded 1 attestation from GitHub API
✓ Verification succeeded!

sha256:89cd1639fe77ab2436f9e69021195951203903e2e6eb012428e6cab80e857f73 was attested by:
REPO                            PREDICATE_TYPE                  WORKFLOW
portefaix/portefaix-distroless  https://slsa.dev/provenance/v1  .github/workflows/release.yaml@refs/tags/v0.0.5
```

### 🏗️ Verify SLSA provenance using Cosign

```shell
$ cosign verify-attestation \
  --type slsaprovenance \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com \
  --certificate-identity-regexp '^https://github.com/slsa-framework/slsa-github-generator/.github/workflows/generator_container_slsa3.yml@refs/tags/v[0-9]+.[0-9]+.[0-9]+$' \
  ghcr.io/portefaix/portefaix-distroless:v0.0.5@sha256:89cd1639fe77ab2436f9e69021195951203903e2e6eb012428e6cab80e857f73
```

## OCI

You could discover all the referrers of manifest with annotations, displayed in a tree view:

```shell
$ oras discover --format tree ghcr.io/portefaix/portefaix-distroless:v0.0.5
ghcr.io/portefaix/portefaix-distroless@sha256:89cd1639fe77ab2436f9e69021195951203903e2e6eb012428e6cab80e857f73
```

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md)

## License

[Apache 2.0 License](./LICENSE)
