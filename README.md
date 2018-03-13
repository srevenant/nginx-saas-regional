# nginx config supporting multi-site multi-region deployment

Conventions:

* Two common variables: ENVIRON and REGION are defined, and files are included/expanded from that,
  by adjusting `nginx.conf.in` at runtime, replacing %ENVIRON% and %REGION% and writing as nginx.conf

      sed -e 's/%ENVIRON%/prd/;s/%REGION%/region1/g' nginx.conf.in > nginx.conf

* On installation this code base is put into /app/nginx and /data/nginx is where content is read from

* /app/nginx paths: (all but locations come in via nginx.conf)

    - html/                       - all common html (favicons, errors)
    - include/                    - common nginx includes used across all other elements
                                    Specifically look at include/ssl-{domain}.conf for SSL configs
    - only-{REGION}-{ENVIRON}.d/  - http{} includes imported only if {REGION} and {ENVIRON} match
    - only-{REGION}.d/            - http{} inlcudes imported only if {REGION} match
    - servers.d/                  - server{} definitions, see example.com.conf for an example
    - location.d/                 - location{} definitions, brought in by servers
    - upstream-{REGION}.d/        - upstream{} definitions, brought in by location{}

* /data/nginx paths:

    - upstream-dynamic.d/         - if you have an agent which makes nginx downstream, put them here