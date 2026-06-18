# re-rotas Helm chart

Runs app in `RAILS_ENV=production` with:

- Rails app container
- optional Postgres sidecar container in same Pod
- optional persistent volume for Postgres data
- optional persistent volume for app `storage/`
- auth disabled by default for local use

## Build image

Build app image from repo root:

```sh
docker build -t re-rotas:latest .
```

Load image into local cluster:

```sh
# kind
kind load docker-image re-rotas:latest

# minikube
minikube image load re-rotas:latest
```

## Install

```sh
helm upgrade --install re-rotas ./helm
kubectl port-forward svc/re-rotas-re-rotas 3000:3000
```

Open http://127.0.0.1:3000

## Important defaults

- `DISABLE_AUTH=1` by default
- `postgres.enabled=true` by default
- Postgres data is ephemeral by default
- app `storage/` is ephemeral by default
- chart assumes single replica

## Override examples

Local with sidecar Postgres:

```sh
helm upgrade --install re-rotas ./helm \
  --set image.repository=re-rotas \
  --set image.tag=latest \
  --set app.secretKeyBase=$(ruby -e 'require "securerandom"; puts SecureRandom.hex(64)') \
  --set app.calendarUrlSalt=$(ruby -e 'require "securerandom"; puts SecureRandom.hex(32)') \
  --set postgres.persistence.enabled=true \
  --set persistence.appStorage.enabled=true
```

Staging/production with external Postgres or RDS:

```sh
helm upgrade --install re-rotas ./helm \
  --set image.repository=re-rotas \
  --set image.tag=latest \
  --set postgres.enabled=false \
  --set externalDatabase.host=mydb.abcdef.eu-west-2.rds.amazonaws.com \
  --set externalDatabase.port=5432 \
  --set externalDatabase.username=rotas \
  --set externalDatabase.password=supersecret \
  --set externalDatabase.database=rotas \
  --set app.disableAuth=false
```

## Caveats

- Postgres sidecar mode is for local/single-pod use only.
- OAuth callback URL is hardcoded to production host when `RAILS_ENV=production`, so real Google login is not practical locally. Keep auth disabled unless app code changes.
