# MoniTutor-docker
Docker images for MoniTutor server and all its dependencies

## Customizing the images
The images can be customized easily by editing `compose-monitutor/options.env` before starting the buildprocess.
If you need to make further changes, check out the compose-file and docker-volumes that are created during startup.

## Running the images
Before starting the build process and running the images, you need to clone all submodules.
```
git submodule update --init --recursive
```
After that, simply `cd compose-monitutor` and start all services with
```
docker-compose build
docker-compose up -d
```
Once the whole stack is up and running, you can access the application via `https://localhost`

## Configuring 
In Order to change web2py's admin password, navigate to [the web2py admin interface](https://localhost/admin). The default password is `admin`. 

You may also need to change the default configuration of MoniTutor. This can be easily done with [web2py's online editor]( https://localhost/admin/default/edit/MoniTutor/private/appconfig.ini?id=private).

To enable clients to connect to rabbit-mq directly, you need to use proper ssl/certificates. See: [rabbit-mq docs: Configure webstomp](https://www.rabbitmq.com/web-stomp.html)
