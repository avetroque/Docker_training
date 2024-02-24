This repo is a part of Data Engineering Zoomcamp 2024. There is another repo called DE_zoomcamp2024, which demonstrates how github codespaces works i.e how to code in the cloud. 

# 1. Introduction

This repo is used to demonstrate how to create a docker (dockerfile+pipeline) on local host machine which can have it's own environment, python version and packages (pandas) 

To do this

1. Download docker for desktop. Click the docker icon and make sure it is running!(else it's not connected)
2. Set enviroment variable HTTP. HTTPS to manual configuration. Else cannot run docker helloworld This can be done using docker GUI-settings
3. Open GitBash
4. Check docker version

``````
docker --version
``````

5. docker hello world

```
docker run hello-world
```


6. Name a file as Dockerfile in vscode/editor. Inside it, build the docker image

7. Name a file as pipeline.py in vscode/editr

8. Build the docker in GitBash. Don't forget the '.' to build in the current dir

```
docker build -t test:pandas .
```

9. Run the build image

```
docker run -it test:pandas
```


# 2. Docker + Postgres

PGCLI and NYTaxi 

postgres basic :
https://www.commandprompt.com/education/how-to-connect-to-postgres-database-server/#:~:text=Open%20the%20%E2%80%9CpgAdmin%E2%80%9D%2C%20provide,command%20to%20connect%20to%20Postgres.

Accessing postgres in windows command prompt
```
psql -U postgres

```
Accessing postgres in windows sql. Press enter until pssword. Pssword enter 'shah'


```
Server [localhost]:
Database [postgres]:
Port [5432]:
Username [postgres]:
Password for user postgres:
psql (16.0)
WARNING: Console code page (850) differs from Windows code page (1252)
         8-bit characters might not work correctly. See psql reference
         page "Notes for Windows users" for details.
Type "help" for help.

postgres=#
```

The command below runs a docker container with postgres image. But make sure to connect host port 5433 to
container-postgres port 5432. Just like 'docker run -it bash' runs a docker with bash image(opens up bash) and 'docker run -it python:3.9' runs a docker with python 3.9 image (opens up python), the below run commands open up a postgres db server connection

You don't necessary build your own docker image, you can just download by doing 'docker run -it image_name'

```
docker run -it \
    -e POSTGRES_USER="root" \
    -e POSTGRES_PASSWORD="root" \
    -e POSTGRES_DB="ny_taxi" \
    -v c:/Users/shahr/code/Docker_training/ny_taxi:/var/lib/postgresql/data \
    -p 5432:5432 \
    postgres:13
```


To run pgcli in GitBash, since you have already installed postgresql(alongside pgadmin) , your username is set as 'postgres'. passwrd is 'shah'

```
pgcli -u postgres
```


Use case
1. Build your own docker images, build/push/upload it, then other devs can download the image and run it

```
docker build -t image_name:image_tag .   #the dot '.' points to current dir

docker run -it image_name:image_tag 
or
docker run -it image_name:image_tag second_parameter 


```

2. You download a docker image from docker, and run it locally 

From https://www.youtube.com/watch?v=2JM-ziJt0WI&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb

```
docker run -it \
    -e POSTGRES_USER="root" \
    -e POSTGRES_PASSWORD="root" \
    -e POSTGRES_DB="ny_taxi" \
    -v c:/Users/shahr/code/Docker_training/ny_taxi:/var/lib/postgresql/data \
    -p 5432:5432 \
    postgres:13

```

Your configuration. MUST CHANGE port to 5433 . port 5432 is already being used by pgadmin4

in gitbash, paste

```
docker run -it \
    -e POSTGRES_USER="root" \
    -e POSTGRES_PASSWORD="root" \
    -e POSTGRES_DB="ny_taxi" \
    -v c:/Users/shahr/code/Docker_training/ny_taxi_postgres_data:/var/lib/postgresql/data \
    -p 5433:5432 \
    postgres:13

```

then only can run in gitbash (in a new window) as below. you can even use password as 'root'.

```
pgcli -h localhost -p 5433 -u root -d ny_taxi
```


# 3.Connecting  to a docker with pgadmin4

```
docker run -it \ 
    -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
    -e PGADMIN_DEFAULT_PASSWORD = "root" \
    -p 8080:80 \
    dpage/pgadmin4
```



# 4. Connecting a docker container with pgadmin to another docker container with postgres

'pg-network' must be the same when creating network (docker network create)
and running postgres (docker run -it --network=pg-network)

```
docker network create pg-network
```

```
docker run -it \
    -e POSTGRES_USER="root" \
    -e POSTGRES_PASSWORD="root" \
    -e POSTGRES_DB="ny_taxi" \
    -v c:/Users/shahr/code/Docker_training/ny_taxi_postgres_data:/var/lib/postgresql/data \
    -p 5433:5432 \
    --network=pg-network \
    --name pg-database \
    postgres:13
```



docker run -it \
    -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
    -e PGADMIN_DEFAULT_PASSWORD="root" \
    -p 8080:80 \
    --network=pg-network \
    --name pgadmin \
    dpage/pgadmin4

