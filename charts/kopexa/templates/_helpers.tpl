{{/* Common labels */}}
{{- define "kopexa.labels" -}}
{{ include "kopexa.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "kopexa.name" -}}
{{- default "kopexa" .Values.kopexa.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Selector labels */}}
{{- define "kopexa.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kopexa.name" . }}
{{- end }}
