# Installation & Configuration of Authentik with Traefik Reverse Proxy!

### (Go to [IBRACORP](https://docs.ibracorp.io/authentik/authentik/docker-compose/npm-forward-auth-single-applications) for the Nginx Proxy Manager Configuration)
You can also watch a video and read the following [`IBRACORP`](https://docs.ibracorp.io/authentik/) documentation of Authentik!


In `fileConfig.yml` of Traefik, add the following settings of Authentik.


```
http:
    ## EXTERNAL ROUTING ##
    routers:

      # Authentik auth routing
      authentik:
        entryPoints:
          - https
        rule: 'Host(`vpsauth.DOMAIN.COM`)'
        service: authentik-auth
        middlewares:
          - "securityHeaders"
  
  
    ## SERVICES ##
    services:
  
      # Authentic auth service
      authentik-auth:
        loadbalancer:
          servers:
            - url: http://authentik:9000    # http://HOSTNAME:INTERNAL-PORT
  
  
  
    ## MIDDLEWARES ##
    middlewares:
      # Authentik guard
      authentik-auth:
        forwardauth:
          address: http://authentik:9000/outpost.goauthentik.io/auth/traefik      # http://HOSTNAME:INTERNAL-PORT
          trustForwardHeader: true
          authResponseHeaders:
              - X-authentik-username
              - X-authentik-groups
              - X-authentik-email
              - X-authentik-name
              - X-authentik-uid
              - X-authentik-jwt
              - X-authentik-meta-jwks
              - X-authentik-meta-outpost
              - X-authentik-meta-provider
              - X-authentik-meta-app
              - X-authentik-meta-version

```

If for some reason the following doesn't proxy Authentik, then add the `Traefik-Real-IP` (Plugin) under security headers.

( External-Port:Internal-Port )

Preview of how the contents inside the file are supposed to look like with your other proxies:

```
http:
    ## EXTERNAL ROUTING ##
    routers:
      traefik:
        entryPoints:
          - https
        rule: 'Host(`vpstraefik.DOMAIN.COM`)'
        service: traefik
        middlewares:
          - "securityHeaders"
          - "authentik-auth"               # Authentik Middleware
  
      #authentik auth routing
      authentik:
        entryPoints:
          - https
        rule: 'Host(`vpsauth.DOMAIN.COM`)'
        service: authentik-auth
        middlewares:
          - "securityHeaders"
  
  
    ## SERVICES ##
    services:
        # Traefik service
      traefik:
        loadBalancer:
          servers:
            - url: http://traefik:8080      # http://HOSTNAME:INTERNAL-PORT  
  
      # Authentic auth service
      authentik-auth:
        loadbalancer:
          servers:
            - url: http://authentik:9000    # http://HOSTNAME:INTERNAL-PORT
  
  
  
    ## MIDDLEWARES ##
    middlewares:
      # Authentik guard
      authentik-auth:
        forwardauth:
          address: http://authentik:9000/outpost.goauthentik.io/auth/traefik      # http://HOSTNAME:INTERNAL-PORT
          trustForwardHeader: true
          authResponseHeaders:
              - X-authentik-username
              - X-authentik-groups
              - X-authentik-email
              - X-authentik-name
              - X-authentik-uid
              - X-authentik-jwt
              - X-authentik-meta-jwks
              - X-authentik-meta-outpost
              - X-authentik-meta-provider
              - X-authentik-meta-app
              - X-authentik-meta-version
  
      # Security headers
      securityHeaders:
        headers:
          customResponseHeaders:
            X-Robots-Tag: "none,noarchive,nosnippet,notranslate,noimageindex"
            server: ""
          sslProxyHeaders:
            X-Forwarded-Proto: https
          referrerPolicy: "same-origin"
          hostsProxyHeaders:
            - "X-Forwarded-Host"
          customRequestHeaders:
            X-Forwarded-Proto: "https"
          contentTypeNosniff: true
          browserXssFilter: true
          forceSTSHeader: true
          stsIncludeSubdomains: true
          stsSeconds: 63072000
          stsPreload: true
          
      traefik-real-ip:
          plugin:
              traefik-real-ip:
                  excludednets: 1.1.1.1/24
```

Now lets go into the Authentik GUI, by going to the host:
`vpsauth.DOMAIN.COM/if/flow/initial-setup/`, make an account and go to `Admin Interface` which is located on the top right of the page.

Follow the steps in order from the images:

![step1-3](https://i.imgur.com/rBhLLPe.png)

![step4-5](https://i.imgur.com/TKlDsNW.png)

![step5-10](https://i.imgur.com/w73cfzx.png)

![step10-12](https://i.imgur.com/N25LwUa.png)

![step12-17](https://i.imgur.com/qNetEkU.png)

Scroll down and click on `Create`.

![step17-19](https://i.imgur.com/8rVFuZ7.png)

Change the configuration settings in there to the following:

```
log_level: info
docker_labels: null
authentik_host: https://vpsauth.DOMAIN.COM      # Change.
docker_network: null
container_image: null
docker_map_ports: true
authentik_host_insecure: false
authentik_host_browser: ""
object_naming_template: ak-outpost-%(name)s
kubernetes_service_type: ClusterIP
kubernetes_image_pull_secrets: []
kubernetes_disabled_components:
  - deployment
  - secret
kubernetes_ingress_annotations: {}
kubernetes_ingress_secret_name: authentik-outpost-tls
kubernetes_replicas: 1
kubernetes_namespace: default
```
Click on the only `Application` in the `Applications` section.

Looks like the following:

![step19-21](https://i.imgur.com/Jfo5lYI.png)

Scroll down and click on `Update`.

Now you are done, you just need to add the middleware that you have in Traefik that is of Authentik to the Routers/Proxied services that you want Authentik to protect.

E.g. 

```
      # Traefik Router
      traefik:
        entryPoints:
          - https
        rule: 'Host(`vpstraefik.DOMAIN.COM`)'
        service: traefik
        middlewares:
          - "securityHeaders"
          - "authentik-auth"               # Authentik Middleware
```
