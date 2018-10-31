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

docker build . --build-arg LOCALAPPFOLDER=<appfolder> --build-arg BOARDSFOLDER=<boardsfolder>

where :
- <appfolder> is the path to the generated app (containing conf.json, mb-package.json, ...)
- <boardsfolder> is the path to the custom boards you want to import

This will generate a docker image that can be started directly

 ### Running

Start the container as follows:

docker run -it --add-host backend:<backendaddress> -p <exposedport>:<misysboardport> <imagename>

where :
- <backendaddress> is the address of the backend server
- <exposedport> shall be replaced by the port that you want available on your machine
- <misysboardport> is the port that the misysboard is exposing when running. Most likely: 3001
- <imagename> is the name of the generated image

Normally, the misysboard should start with no error. If you cannot login, then
a connection error with the backend might have happened. Please double check
the address of the cargo backend.

If you want to start the process in background, simply replace "-it" by "-d" in
the options.

 ### Contact

 In case of any questions catch the solution integration team