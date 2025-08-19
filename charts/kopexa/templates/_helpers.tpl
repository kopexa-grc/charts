{{/*
Expand the name of the chart.
*/}}
{{- define "kopexa.name" -}}
{{- (default .Chart.Name .Values.nameOverride) | toString | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kopexa.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create unified labels for kopexa components
*/}}
{{- define "kopexa.common.matchLabels" -}}
release: {{ .Release.Name }}
app.kubernetes.io/name: {{ template "kopexa.name" . }}
app.kubernetes.io/part-of: {{ template "kopexa.name" . }}
{{- end -}}

{{- define "kopexa.common.metaLabels" -}}
chart: {{ template "kopexa.chart" . }}
heritage: {{ .Release.Service }}
{{- end -}}


{{- define "kopexa.common.labels" -}}
{{ include "kopexa.common.matchLabels" . }}
{{ include "kopexa.common.metaLabels" . }}
{{- end -}}

{{- define "kopexa.frontend.labels" -}}
{{ include "kopexa.frontend.matchLabels" . }}
{{ include "kopexa.common.metaLabels" . }}
{{- end -}}

{{- define "kopexa.frontend.matchLabels" -}}
app.kubernetes.io/component: {{ .Values.kopexa.frontend.name | quote }}
{{ include "kopexa.common.matchLabels" . }}
{{- end -}}

{{/*
Create a fully qualified backend name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "kopexa.frontend.fullname" -}}
{{- if .Values.kopexa.frontend.fullnameOverride -}}
{{- .Values.kopexa.frontend.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.kopexa.frontend.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.kopexa.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}