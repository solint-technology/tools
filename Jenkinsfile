import groovy.json.*
import groovy.io.FileType

token = "eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NDIyODQyNTcsImZpcnN0X3RpbWUiOmZhbHNlLCJpYXQiOjE1Mzk2OTIyNTcsIm5hbWUiOiJKZW5raW5zIiwicm9sZSI6InNjYW5uZXIiLCJzdWIiOiJqZW5raW5zIn0.RVrk8wihk1IpB9ZTQ4Va7C8WtsgXBDtUCe06p26-vQYpbJWSyW6mag20-9SxQdrqs67SqqlV4wgYEzhTw61CGdxxQGlcqJSb4AHsq4GEg5tBMGSmwhfXRwqsyZlyo7bVPQrlZuLpBju-42ICIwh69yoptogY1tLZ5eu5kimvsH_ZHfyoxvrRma4esarnHqvKzVtnP3aIrABy0dUDbMduSVQMqcSwAJLKzZAkvEkyDGU6aI3W_QQP4dcJMpBNdA-eH1jnlTnOKQDHpzEzonRpSHvIprJguppdGlBuJ2Y-3-6JUu9xrB7EkZqSWHb-3wbZMutSk_MeALm4OwSk8yiWWw"

def jsonParse(def json) {
    return new groovy.json.JsonSlurperClassic().parseText(json)
}

def mountOption(def src, def dest) {
    return "--mount type=bind,source=" + src + ",destination=" + dest
}

def buildImage(def imagename) {
    sh("docker build . -t " + imagename)
}

def testImage(def cstimage, def publicname) {
    sh([
        "docker run --rm",
        mountOption(pwd(), "/data"),
        mountOption("/var/run/docker.sock", "/var/run/docker.sock"),
        cstimage,
        "test --image",
        publicname,
        "--config /data/test_config.yaml"
    ].join(" "))
}

def pushImage(def publicname) {
    sh("docker push " + publicname)
}

def triggerImageScan(def publicname) {
    def resp = sh(script: "curl -X POST \
                     http://fr1pslbmc04:8080/api/v1/scanner/registry/Finastra%20DTR/image/" + publicname + "/scan \
                     -H 'Authorization: Bearer " + token + "'  \
                     -H 'Content-Type: application/json'",
                  returnStdout: true
	         ).trim()
    if(jsonParse(resp).status != "Sent To Scan") {
        throw new Exception("Couldn't scan image. Reason: " + jsonParse(resp).message)
    } else {
        echo "Image sent to scan"
    }
}

def getTestName(def imagename) {
     return "solint/" + imagename + "-test"
}

def oneImageFlow(def image) {
    cstimage = "gcr.io/gcp-runtimes/container-structure-test:1.5.0"
    testimagename = getTestName(image)
    publicname = "registry.misys.global.ad/" + testimagename
    stage("[" + image + "] Build") {
        buildImage(publicname)
    }
    stage("[" + image + "] Container Structure Test") {
        testImage(cstimage, publicname)
    }
    stage("[" + image + "] Push") {
        pushImage(publicname)
    }
    stage("[" + image + "] Trigger scan") {
        triggerImageScan(testimagename)
    }
}

def buildOneImage(def position, def image) {

    dir(position) {
        try {
            oneImageFlow(image)
            return 0
        } catch (err) {
            echo "Couldn't build image " + image + " because " + err
            return 1
        }
    }
}

def getScanResult(def image) {
    def scanning = true
    while(scanning) {
        sh "sleep 5"
        def resp = sh(script: "curl -X GET \
                 http://fr1pslbmc04:8080/api/v1/scanner/registry/Finastra%20DTR/image/" + image + "/status \
                 -H 'Authorization: Bearer " + token + "'  \
                 -H 'Content-Type: application/json'",
              returnStdout: true
        ).trim()
        echo resp
        scanning = ( jsonParse(resp).status == "Pending" )
    }
    try {
        def resp = sh(script: "curl -X GET \
                 http://fr1pslbmc04:8080/api/v1/scanner/registry/Finastra%20DTR/image/" + image + "/scan_result \
                 -H 'Authorization: Bearer " + token + "'  \
                 -H 'Content-Type: application/json'",
              returnStdout: true
        ).trim()
        echo resp
        return jsonParse(resp).disallowed
    } catch(err) {
        echo "Couldn't get image status"
        return false
    }
}

def cpImage(def src, def dest) {
    sh("docker tag " + src + " " + dest)
}

def checkOneImageAqua(def image) {
    testimagename = getTestName(image)
    publictestname = "registry.misys.global.ad/" + testimagename
    publicname = "registry.misys.global.ad/solint/" + image

    def disallowed = getScanResult(testimagename)

    if(disallowed == false) {
        cpImage(publictestname, publicname)
        pushImage(publicname)
    } else {
        throw new Exception("Image not allowed")
    }
}

def pushOneImageStatusCheck(def image) {
        try {
            stage("[" + image + "] Check AQUA status") {
                    checkOneImageAqua(image)
            }
            stage("[" + image + "] Push image") {
                    pushImage("registry.misys.global.ad/solint/" + image)
            }
            return 0
        } catch(err) {
            echo "Couldn't push image " + image + " because " + err
            return 1
        }
}

def displayResults(def images, def cst, def aqua) {
    def output = "Image|CST|Aqua\n"

    for ( int i = 0; i < dirs.size(); i++) {
        output += images[i] + "|"
        if(CSTOk[i]) output += "X|"
        if(aquaScan[i]) output += "X"
        output += "\n"
    }

    writeFile file: "table", text: output
    sh 'cat table | column -t -s "|"'
    sh 'rm table'
}

node("docker") {
    deleteDir()

    stage("Clone repo") {
        wrap([$class: 'ConfigFileBuildWrapper',
                managedFiles: [[fileId: "${env.PIPELINE_CONFIG ?: 'jenkins-pipeline-configuration'}",
                replaceTokens: false,
                variable: 'PIPELINE_CONFIG_FILE']]]) {
            scmconfig = jsonParse(readFile("${env.PIPELINE_CONFIG_FILE}")).default
        }
        git branch: env.BRANCH_NAME, url: "ssh://git@scm-git-eur.misys.global.ad:7999/solint/technology.git", credentialsId: scmconfig.general.git.credentials
    }

    dirs = sh(script: 'echo docker/*/*', returnStdout: true).replace("\n", "").split(" ")
    images = new String[dirs.size()]
    for ( int i = 0; i < dirs.size(); i++) {
        images[i] = dirs[i]
                        .replace("docker/", "")
                        .replace("/", ":")
    }
    CSTOk = new Boolean[dirs.size()]
    aquaScan = new Boolean[dirs.size()]

    for ( int i = 0; i < dirs.size(); i++) {
        returnCode = buildOneImage(dirs[i], images[i])
        CSTOk[i] = (returnCode == 0)
    }

    for ( int i = 0; i < dirs.size(); i++) {
        if(CSTOk[i]) {
            returnCode = pushOneImageStatusCheck(images[i])
            aquaScan[i] = (returnCode == 0)
        }
    }

    displayResults(images, CSTOk, aquaScan)
}
