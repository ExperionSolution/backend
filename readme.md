# E-commerce
This project is built with docker containers using docker-compose files.

Requirements

 - [Docker](https://www.docker.com/)

To lift the project we must be in the root directory and execute the following command

    docker compose build && docker compose up -d

-   To configure pgadmin – open a browser and go to –  [http://localhost:5050/](http://localhost:5050/)  . In the connection details for hostname give the container name of postgreSQL