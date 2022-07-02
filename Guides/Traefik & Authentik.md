# Installation & Configuration of Authentik with Traefik Reverse Proxy

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




