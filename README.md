- Criar bucket (controle de acesso uniforme)

- criar conta de serviço (adm do storage)

- baixar keyfile.json e codificar base64 (cat keyfile.json | base64 -w 0)

- Adicionar variável de ambiente GOOGLE_CREDENTIALS com valor igual a keyfile em base64 no Dockerfile ou deploy manifest k8s

- adicionar gem: gem "google-cloud-storage"

- configurar storage file:

google:
  service: GCS
  project: rails-lab-264600
  credentials: <%= Base64.decode64(ENV['GOOGLE_CREDENTIALS']) %>
  bucket: rails-gcs

- configurar storage type em cada ambiente (config>enviroments>development;production)

config.active_storage.service = :google


