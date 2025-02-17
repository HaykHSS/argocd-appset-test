{{/*
    Name Overrides
    */}}
    
    {{- define "base-chart.fullname" -}}
    {{- if .Values.nameOverride }}
    {{- .Values.nameOverride }}
    {{- else if .Values.nameAppend -}}
    {{- .Values.app }}-{{- .Values.nameAppend }}
    {{- else }}
    {{- .Values.app }}
    {{- end }}
    {{- end }}
    
    {{- define "base-chart.deployname" -}}
    {{- if .Values.nameOverride }}
    {{- .Values.nameOverride }}
    {{- else if .Values.nameAppend -}}
    {{- .Release.Name }}-{{- .Values.nameAppend }}
    {{- else }}
    {{- .Release.Name }}
    {{- end }}
    {{- end }}
    
    {{- define "base-chart.imagename" -}}
    {{- if .Values.imageOverride }}
    {{- .Values.imageOverride }}
    {{- else if .Values.imageAppend -}}
    {{- .Values.image }}-{{- .Values.imageAppend }}
    {{- else }}
    {{- .Values.image }}
    {{- end }}
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
    