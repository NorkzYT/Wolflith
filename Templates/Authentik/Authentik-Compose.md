# Info of Authentik Docker-Compose


In the `.env` file that will be in the same folder as the `authentik` docker-compose, needs to contain the following and you only need to change the `$SECURE` placeholders.
```
AUTHENTIK_REDIS__PASSWORD=$SECURE

POSTGRES_PASSWORD=$SECURE
POSTGRES_USER=postgres
POSTGRES_DB=postgres

AUTHENTIK_POSTGRESQL__NAME=authentik

AUTHENTIK_SECRET_KEY=$SECURE

GEOIPUPDATE_ACCOUNT_ID=$SECURE  #
GEOIPUPDATE_LICENSE_KEY=$SECURE
```

### How to get the GEO IP