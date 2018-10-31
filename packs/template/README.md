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

 docker build .

 This will generate a docker image that can be started directly.

 ### Running

Start the container as follows:

docker run -it  <imagename>

where :
- <imagename> is the name of the generated image

If you want to start the process in background, simply replace "-it" by "-d" in
the options.

 ### Contact

 In case of any questions catch the solution integration team