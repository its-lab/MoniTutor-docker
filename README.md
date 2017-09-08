# MoniTutor-docker
Docker images for MoniTutor server and all its dependencies

# Running the images
Simply `cd compose-monitutor` and start all services with
```
docker-compose build
docker-compose up -d
```
After the whole stack is up and running, you can access the application via `https://localhost`

# Customizing the images
The images can be customized easily by editing `compose-monitutor/options.env`
If you need to make further changes, check out the compose-file and docker-volumes that are created during startup.
