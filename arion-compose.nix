{
  project.name = "";
  services = rec {
    db.service = {
        image = "postgres:14";
        container_name = "hasura_db";
        networks = [ "default" ];
        environment = {
          "POSTGRES_USER" = "postgres";
          "POSTGRES_PASSWORD_FILE" = "postgrespassword";
        };
        volumes = [
          "db_data:/var/lib/postgresql/data"
        ];
    };
    docker-compose.volumes = { db_data = {}; };
  };
}

