{{/*
Name Overrides
*/}}

{{- define "base-chart.fullname" -}}
some_name
{{- end }}

{{- define "base-chart.deployname" -}}
some_deployname
{{- end }}

{{/*
Common labels
*/}}

{{- define "common.labels" -}}
metaLabel: {{ include "base-chart.fullname" . }}-{{ .Release.Name }}
app.kubernetes.io/name: {{ include "base-chart.fullname" . }}
helm.sh/chart: {{ include "base-chart.fullname" . }}-{{ .Values.chartVersion }}
version: {{ include "base-chart.deployname" . }}-v1
tags.datadoghq.com/service: {{ include "base-chart.fullname" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
team: {{ .Values.team }}
provider: {{ .Values.provider }}
project: {{ .Values.project }}
cluster: {{ .Values.cluster }}
region: {{ .Values.region }}
environment: {{ .Release.Name }}
tags.datadoghq.com/env: {{ .Release.Name }}
tags.datadoghq.com/version: {{ .Values.commit | quote | default "unknown" }}
{{- end -}}
{{- define "common.labels2" -}}
metaLabel: {{ include "base-chart.fullname" . }}-{{ .Release.Name }}
app.kubernetes.io/name: {{ include "base-chart.fullname" . }}
helm.sh/chart: {{ include "base-chart.fullname" . }}-{{ .Values.chartVersion }}
{{- end -}}
