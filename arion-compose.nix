{
  project.name = "hasura";
  networks = {
    hasura = {};
  };

  services = rec {
    db.service = {
        image = "postgres:14";
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
    image = "hasura/graphql-engine:v2.35.1";
    ports = ["8080:8080"];
    depends_on = ["db"];
    networks = [ "hasura" ];
    environment = {
          "HASURA_GRAPHQL_METADATA_DATABASE_URL" = "postgresql://postgres:postgrespassword@db:5432/postgres";
          "HASURA_GRAPHQL_DATABASE_URL"= "postgresql://postgres:postgrespassword@db:5432/postgres";
          "HASURA_GRAPHQL_ENABLE_CONSOLE" = "true";
          "HASURA_GRAPHQL_DEV_MODE"= "true";
          "HASURA_GRAPHQL_ENABLED_LOG_TYPES" = "startup, http-log, webhook-log, websocket-log, query-log";
        };
    };
  };
}

