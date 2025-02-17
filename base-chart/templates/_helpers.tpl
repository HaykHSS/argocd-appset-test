{{/*
Expand the name of the chart.
*/}}
{{- define "base-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "base-chart.fullname" -}}
{{- if .Values.global.fullnameOverride }}
{{- .Values.global.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "base-chart.chart" -}}
{{- printf "%s-%s" .Values.nameOverride .Values.chartVersion | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "base-chart.labels" -}}
helm.sh/chart: {{ include "base-chart.chart" . }}
{{ include "base-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "common.labels" -}}
helm.sh/chart: base-val
team: base-team
{{- end }}

{{/*
    Common labels
*/}}
    
{{- define "common.labelsorigin" -}}
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


{{/*
Selector labels
*/}}
{{- define "base-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "base-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "base-chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "base-chart.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
