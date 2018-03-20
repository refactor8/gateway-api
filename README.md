# api-gateway

Rails 5 API gateway template to handle the multi-tenant authentication and authorization from the external callers to the microservice level using JSON Web Tokens (JWT).

JWT authentication was implemented from scratch. For a better solution check the [knock gem.](https://github.com/nsarno/knock)

Subdomains and multitenancy were implemented from scratch. For a better solution check the [apartment gem](https://github.com/influitive/apartment)

## Overview
The API Gateway is the entry point to all the services that your application is providing. It's responsible for service discovery (from the client side), routing the requests coming from external callers to the right microservices. Whenever the user wants to access a certain resource, he'll request it from the API Gateway and will send the JWT along with his request. The API Gateway will forward the request with the JWT to the microservice that owns this resource. The microservice will then decide to either grant the user the resource (if the user has the required permissions) or not. Based on the implementation, the microservice can make this decision by itself (if it knows the permissions of this user over this resource) or simply forward the request to one of the Authorization Servers within the environment to determine the user's permissions.

To illustrate further, a user starts by sending his credentials to the API gateway which will forward the credentials to the Authorization Server (AS). The AS will generate a JSON Web Token (JWT) and will return it back to the user.

## Prerequisites

This example app can be run with [Docker](https://www.docker.com) and [Docker Compose](https://docs.docker.com/compose/). To support this, you must have Docker installed and running locally. You may also require that the Docker daemon supports connections on the default Unix socket /var/run/docker.sock

On macOS, I recommend using [Docker for Mac](https://docs.docker.com/docker-for-mac/).

## Setup instructions

Add your application configuration to your `.env` file in the root of your project:

```shell
API_GATEWAY_DB
```
The database name
```shell
API_GATEWAY_DB_ROLE
```
Database role
```shell
API_GATEWAY_DB_PASSWORD
```
The password for the user set in the API_GATEWAY_DB_ROLE environment variable
```shell
API_GATEWAY_SECRET_KEY_BASE
```
The application secret key value found in config/secrets.yml. Rails provides ```rake secret``` for just this purpose.
```shell
API_GATEWAY_DB_HOST
```
The PostgreSQL server listening port
```shell
API_GATEWAY_DB_PORT
```
The PostgreSQL database port

## Running the example

Once you've set the environment variables, run ```bundle install```, then run ```rails server```.

## Running the example using Docker

Run the containers

```shell
docker-compose up
```

Create the database

```shell
docker-compose run app rake db:create
```

Run migrations

```shell
docker-compose run app rake db:migrate
```
