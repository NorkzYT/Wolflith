# Info of Authentik Docker-Compose


In the `.env` file that will be in the same folder as the `authentik` docker-compose, needs to contain the following and you only need to change the `$SECURE` placeholders.
```
POSTGRES_PASSWORD=$SECURE

AUTHENTIK_SECRET_KEY=$SECURE

GEOIPUPDATE_ACCOUNT_ID=$SECURE 
GEOIPUPDATE_LICENSE_KEY=$SECURE
```

If your not going to use `GEOIPUPDATE` then remove it from the `.env` file.

Configuration settings of [Authentik](https://goauthentik.io/docs/installation/configuration).