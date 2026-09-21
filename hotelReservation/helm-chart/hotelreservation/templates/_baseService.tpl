{{- define "hotelreservation.templates.baseService" }}
apiVersion: v1
kind: Service
metadata:
  name: {{ .Values.name }}-{{ include "hotel-reservation.fullname" . }}
  {{- if .Values.service }}
  {{- if .Values.service.labels }}
  labels:
    {{- toYaml .Values.service.labels | nindent 4 }}
  {{- end }}
  {{- if .Values.service.annotations }}
  annotations:
    {{- toYaml .Values.service.annotations | nindent 4 }}
  {{- end }}
  {{- end }}
spec:
  type: {{ .Values.serviceType | default .Values.global.serviceType }}
  ports:
  {{- range .Values.ports }}
  - name: "{{ .port }}"
    port: {{ .port }}
    {{- if .protocol}}
    protocol: {{ .protocol }}
    {{- end }}
    targetPort: {{ .targetPort }}
  {{- end }}
  selector:
    {{- include "hotel-reservation.selectorLabels" . | nindent 4 }}
    service: {{ .Values.name }}-{{ include "hotel-reservation.fullname" . }}
{{- end }}
