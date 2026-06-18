{{- define "re-rotas.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "re-rotas.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name (include "re-rotas.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "re-rotas.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "re-rotas.labels" -}}
helm.sh/chart: {{ include "re-rotas.chart" . }}
app.kubernetes.io/name: {{ include "re-rotas.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "re-rotas.selectorLabels" -}}
app.kubernetes.io/name: {{ include "re-rotas.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "re-rotas.secretName" -}}
{{- printf "%s-secrets" (include "re-rotas.fullname" .) -}}
{{- end -}}

{{- define "re-rotas.postgresPvcName" -}}
{{- printf "%s-postgres" (include "re-rotas.fullname" .) -}}
{{- end -}}

{{- define "re-rotas.appStoragePvcName" -}}
{{- printf "%s-storage" (include "re-rotas.fullname" .) -}}
{{- end -}}
