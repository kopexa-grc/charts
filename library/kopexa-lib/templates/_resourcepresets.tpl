{{/* vim: set filetype=mustache: */}}

{{- define "kopexa-lib.resources.unsanitizedPreset" }}

{{-   $baseCPU := dict
        "nano"    (dict "cpu" "250m" )
        "micro"   (dict "cpu" "500m" )
        "small"   (dict "cpu" "1"    )
        "medium"  (dict "cpu" "1"    )
        "large"   (dict "cpu" "2"    )
        "xlarge"  (dict "cpu" "4"    )
        "2xlarge" (dict "cpu" "8"    )
}}
{{-   $baseMemory := dict
        "nano"    (dict "memory" "128Mi" )
        "micro"   (dict "memory" "256Mi" )
        "small"   (dict "memory" "512Mi" )
        "medium"  (dict "memory" "1Gi"   )
        "large"   (dict "memory" "2Gi"   )
        "xlarge"  (dict "memory" "4Gi"   )
        "2xlarge" (dict "memory" "8Gi"   )
}}
{{-   $baseEphemeralStorage := dict
        "nano"    (dict "ephemeral-storage" "2Gi" )
        "micro"   (dict "ephemeral-storage" "2Gi" )
        "small"   (dict "ephemeral-storage" "2Gi" )
        "medium"  (dict "ephemeral-storage" "2Gi" )
        "large"   (dict "ephemeral-storage" "2Gi" )
        "xlarge"  (dict "ephemeral-storage" "2Gi" )
        "2xlarge" (dict "ephemeral-storage" "2Gi" )
}}

{{-   $presets := merge $baseCPU $baseMemory $baseEphemeralStorage }}
{{-   if not (hasKey $presets .) -}}
{{-     printf "ERROR: Preset key '%s' invalid. Allowed values are %s" . (join "," (keys $presets)) | fail -}}
{{-   end }}
{{-   index $presets . | toYaml }}
{{- end }}

{{/*
  Return a resource request/limit object based on a given preset.
  {{- include "kopexa-lib.resources.preset" list ("nano" $) }}
*/}}
{{- define "kopexa-lib.resources.preset" -}}
{{-   $cpuAllocationRatio := include "kopexa-lib.resources.cpuAllocationRatio" . | float64 }}
{{-   $args := index . 0 }}
{{-   $global := index . 1 }}
{{-   $unsanitizedPreset := include "kopexa-lib.resources.unsanitizedPreset" list ($args $global) | fromYaml }}
{{-   include "kopexa-lib.resources.sanitize" (list $unsanitizedPreset $global) }}
{{- end -}}
