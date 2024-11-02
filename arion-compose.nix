{
  project.name = "hasura";
  networks = {
    hasura = {};
  };

  services = rec {
    db.service = {
        image = "postgis/postgis:17-3.5";
        container_name = "hasura_db";
        networks = [ "hasura" ];
        ports = ["5432:5432"];
        environment = {
          "POSTGRES_USER" = "postgres";
          "POSTGRES_PASSWORD" = "postgrespassword";
        };
        volumes = [
          "${toString ./.}/postgres-data:/var/lib/postgresql/data"
        ];
    };

  graphql-engine.service = {
    image = "hasura/graphql-engine:v2.44.0";
    ports = ["8080:8080"];
    depends_on = ["db"];
    networks = [ "hasura" ];
    environment = {
          "HASURA_GRAPHQL_METADATA_DATABASE_URL" = "postgresql://postgres:postgrespassword@db:5432/postgres";
          "HASURA_GRAPHQL_DATABASE_URL"= "postgresql://postgres:postgrespassword@db:5432/postgres";
          "HASURA_GRAPHQL_ENABLE_CONSOLE" = "true";
          "HASURA_GRAPHQL_DEV_MODE"= "true";
          "HASURA_GRAPHQL_ADMIN_SECRET"= "myadminsecretkey";
          "HASURA_GRAPHQL_ENABLED_LOG_TYPES" = "startup, http-log, webhook-log, websocket-log, query-log";
        };
    };

        #docker run -e ROUNDCUBEMAIL_DEFAULT_HOST=mail -e ROUNDCUBEMAIL_SMTP_SERVER=mail -p 8000:80 -d roundcube/roundcubemail

        #roundcubemail.service = {
        #  image = "roundcube/roundcubemail:latest";
        #  networks = [ "hasura" ];
        #  ports = ["8000:80"];
        #      environment = {
        #          "ROUNDCUBEMAIL_DEFAULT_HOST"="tls://dovecot:993";
        #          "ROUNDCUBEMAIL_SMTP_SERVER"="dovecot";
        #          "ROUNDCUBEMAIL_USERNAME_DOMAIN"="valerio.guru";
        #      };
        #};

  dovecot.service = {
    image = "dovecot/dovecot:2.3-latest";
    networks = [ "hasura" ];
    ports = ["1993:993" "4190:4190" "1587:587"];
    volumes = [
      "${toString ./.}/mail:/srv/mail"
      "${toString ./.}/dovecot.conf:/etc/dovecot/dovecot.conf"
    ];
    };
  };
}
