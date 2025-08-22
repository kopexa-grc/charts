# kopexa

**Homepage:** <https://kopexa.com>

## Prerequisites

- [Helm](https://helm.sh/docs/intro/install/)
- [ct](https://github.com/helm/chart-testing)
- [helm-docs](https://github.com/norwoodj/helm-docs)
- [task](https://taskfile.dev/)

Once you've installed `task` you can simply run `task install` to get the remaining dependencies installed, assuning you're using macOS and have `brew`.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Kopexa Team | <hello@kopexa.com> | <https://kopexa.com> |

## Description

A Helm chart to deploy Kopexa Server on Kopexa Infrastructure

## Source Code

* <https://github.com/kopexa-grc/charts>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| nameOverride | string | `""` | Overrides the default release name |
| fullnameOverride | string | `""` | Overrides the full name of the release, affecting resource names |
| kopexa.domain | string | `"kopexa.com"` |  |
| kopexa.podAnnotations | object | `{}` | Custom annotations for Kopexa pods |
| kopexa.common.labels | string | `nil` |  |
| kopexa.common.matchLabels | string | `nil` |  |
| kopexa.common.metaLabels | string | `nil` |  |
| kopexa.backend.host | string | `"api.{{ .Values.kopexa.domain }}"` | Hostname for the Kopexa Backend Service |
| kopexa.backend.publicBaseURL | string | `"https://api.{{ .Values.kopexa.domain }}"` |  |
| kopexa.realtime.host | string | `"api.{{ .Values.kopexa.domain }}"` | Hostname for the Kopexa Realtime Service |
| kopexa.realtime.publicBaseURL | string | `"wss://api.{{ .Values.kopexa.domain }}"` | Public base URL for the Kopexa Realtime Service |
| kopexa.frontend.host | string | `"app.{{ .Values.kopexa.domain }}"` | Hostname for the Kopexa Frontend Service |
| kopexa.frontend.publicBaseURL | string | `"https://app.{{ .Values.kopexa.domain }}"` | Public base URL for the Kopexa Frontend |
| kopexa.frontend.replicaCount | int | `3` |  |
| kopexa.frontend.fullnameOverride | string | `""` |  |
| kopexa.frontend.name | string | `"frontend"` |  |
| kopexa.frontend.image.repository | string | `"ghcr.io/kopexa-grc/kopexa-frontend"` | Image repository for the Kopexa Frontend Service |
| kopexa.frontend.image.tag | string | `""` | Specific version tag of the Kopexa Frontend image. View the latest version here |
| kopexa.frontend.image.pullPolicy | string | `""` | Pulls image only if not present on the node |
| kopexa.frontend.image.imagePullSecrets | list | `[]` | Secret references for pulling the image, if needed |
| kopexa.frontend.labels | string | `nil` |  |
| kopexa.frontend.matchLabels | string | `nil` |  |
| kopexa.frontend.topologySpreadConstraints | list | `[]` | Ref: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/ |
| kopexa.frontend.affinity | object | `{}` | Node affinity settings for pod placement |
| kopexa.frontend.tolerations | list | `[]` | Tolerations definitions |
| kopexa.frontend.nodeSelector | object | `{}` | Node selector for pod placement |
| kopexa.frontend.podSecurityContext | object | `{"fsGroup":1001,"runAsGroup":1001,"runAsUser":1001}` | Pod security context settings |
| kopexa.frontend.resources | object | `{"limits":{"cpu":"2000m","memory":"2048Mi"},"requests":{"cpu":"500m","memory":"512Mi"}}` | Resource requests and limits for the Kopexa Frontend pods |
| kopexa.frontend.resources.limits.memory | string | `"2048Mi"` | Memory limit for the Kopexa Frontend pods |
| kopexa.frontend.resources.limits.cpu | string | `"2000m"` | CPU limit for the Kopexa Frontend pods |
| kopexa.frontend.resources.requests.cpu | string | `"500m"` | CPU request for the Kopexa Frontend pods |
| kopexa.frontend.resources.requests.memory | string | `"512Mi"` | Memory request for the Kopexa Frontend pods |
| kopexa.frontend.service.type | string | `""` | Service type, can be changed based on exposure needs (e.g., LoadBalancer) |
| kopexa.frontend.service.annotations | object | `{}` | Custom annotations for Kopexa service |
| kopexa.frontend.service.nodePort | string | `""` | Optional node port for service when using NodePort type |

## Update documentation

Each of the charts in this repository has a `README.md` which contains chart-specific instructions or information (non-templated information) and additionally a `HELM.md`. This allows all the benefits of templating to be used in the `HELM.md` while still allowing for chart-specific documentation to be added and not be overridden. The general goal is that all the charts share the same templating configuration so that global functionality / updates can be made and applied to all charts rather than individually managing each chart's documentation via the templating mechanisms.

Chart documentation in the `HELM.md` is generated with [helm-docs](https://github.com/norwoodj/helm-docs) from `values.yaml` file.

After file modification, regenerate README.md with command:

```bash
task docs
```

OR if you want to attempt to run it without task, you can use optionally use the docker image although there is no stock Task provided for this:

```bash
docker run --rm -it -v $(pwd):/helm --workdir /helm jnorwood/helm-docs:v1.14.2 helm-docs
```

Globally updating all charts' documentation can be done by running the following command from the root of the repository:

```bash
task docs
```

## Run linter

To run the linter on this chart, you can use the `ct` tool. This will check for common issues in the chart and ensure it adheres to best practices. You can also run Helm's `lint` and for convenience, the task command below runs both `ct lint` and `helm lint` commands. You can run them individually if you prefer via `task lint:ct` and `task lint:helm`.

You can run both linters with the following command:

```bash
task lint
```

OR if you'd like to run the ct lint process by using a docker image, you can use a command like the following:

```bash
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/kopexa --config /charts/charts/kopexa/ct.yml
```