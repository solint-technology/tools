## Installation procedure
## How to test ?

Docker images are listed in the docker folder and generated automatically via the pipeline.
In order to provide easy testing on those images, we are using "container-structure-test",
a tool developed by Google. The repo can be found here:

https://github.com/GoogleContainerTools/container-structure-test

Once installed the container-structure test can be used simply as follows, for each of the image in the correct
folder :

    container-structure-test test --image solint/java-ubuntu:8u181-jre --config test_config.yaml

They are also tested for security issues using Aqua Security Testing. More info here;

https://www.aquasec.com/
