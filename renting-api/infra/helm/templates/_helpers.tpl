{{/*
Expand the name of the chart.
*/}}
{{- define "bookstore-renting-api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bookstore-renting-api.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
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
{{- define "bookstore-renting-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "bookstore-renting-api.labels" -}}
bookstore-renting-api.sh/chart: {{ include "bookstore-renting-api.chart" . }}
{{ include "bookstore-renting-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "bookstore-renting-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bookstore-renting-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "bookstore-renting-api.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- $saname := default (include "bookstore-renting-api.name" .) .Values.serviceAccount.name }}
{{- printf "%s-%s" $saname "service-account" | trunc 63 | trimSuffix "-" }}

{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}