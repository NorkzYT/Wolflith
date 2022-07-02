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

Now lets go into the Authentik GUI, login and go to `Admin Interface` which is located on the top right of the page.

Follow the steps in order from the images:

![step1-3](https://i.imgur.com/iswxgYF.png)




