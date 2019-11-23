The following will validate the upstream functionality of CONSUL by deploying two pods.
POD A - SPRING application with DB as it's backend
POD B - MYSQL DB 

POD A will connect using CONSUL service mesh to the DB by defninig the anntoation:
    "consul.hashicorp.com/connect-service-upstreams": "db_mysql:3306"


