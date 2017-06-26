[proxy]
ip = ""
port = ""
user = ""
password = ""

[http]
user_agent = "Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6) Gecko/20100628 Ubuntu/10.04 (lucid) Firefox/3.6.6"

[general]
check_start = 7
check_end = 24
version = 3.4
baseurl = "{{.CHEKY_BASEURL}}"

[storage]
type = "files"

{{ if eq .CHEKY_CONFIG_MAILER "1" -}}
[mailer]
smtp[host] = "{{.CHEKY_MAILER_SMTP_HOST}}"
smtp[port] = {{.CHEKY_MAILER_SMTP_PORT}}
smtp[username] = "{{.CHEKY_MAILER_SMTP_USERNAME}}"
smtp[password] = "{{.CHEKY_MAILER_SMTP_PASSWORD}}"
smtp[secure] = "{{.CHEKY_MAILER_SMTP_SECURE}}"
from = "{{.CHEKY_MAILER_FROM}}"
{{ end }}