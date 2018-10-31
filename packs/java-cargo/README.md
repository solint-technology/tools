## DRAFT README

 Hey, it looks like you pulled this package from the Draft repo !
 If you want to use this Dockerfile it is really simple just follow the steps:

 ### Prerequisites

 Now, your app directory should contains the following files.

 ```
 \---app
     |   Dockerfile
     |   .dockerignore
     |   README.md
```

 ### Building

 First of all, you will need to create the docker image. To do so, execute
 the following command:

 docker build . --build-arg TARGETNAME=<cargopackage> --build-arg ELSPORT=<elsport>

 where :
 - <cargopackage> is the path to your cargo package
 - <elsport> is the port used to connect to the ELS server

 This will generate a docker image that can be started directly.

 ### Running

Start the container as follows:

docker run -it --add-host kenvng:<kenvng> --add-host elsd-1-<elsport>:<elsserver> -p <exposedport>:<cargoport> <imagename>

where :
- <kenvng> is the address of the zone containing the data
- <elsport> shall be replaced by the port used to connect to the els server
- <elsserver> shall be replace by the address of the required els server
- <exposedport> shall be replaced by the port that you want available on your machine
- <cargoport> is the port that cargo is exposing when running
- <imagename> is the name of the generated image

Normally, the cargo server should start without error and start its job. You
should also be able to see the logs of cargo on the console, without opening
the server.log.

If you want to start the process in background, simply replace "-it" by "-d" in
the options.

 ### Contact

 In case of any questions catch the solution integration team