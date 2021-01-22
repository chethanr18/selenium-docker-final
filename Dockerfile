FROM openjdk:8u191-jre-alpine3.8

RUN apk add curl jq

# Workspace
WORKDIR /usr/share/udemy

# ADD .jar under target from host
# into this image
ADD target/selenium-docker-final.jar 			selenium-docker-final.jar
ADD target/selenium-docker-final-tests.jar 	selenium-docker-final-tests.jar
ADD target/libs							libs

# in case of any other dependency like .csv / .json / .xls
# please ADD that as well

# ADD suite files
ADD book-flight-module.xml				book-flight-module.xml
ADD search-module.xml					search-module.xml

ADD healthcheck.sh healthcheck.sh
RUN dos2unix healthcheck.sh
#RUN wget https://s3.amazonaws.com/selenium-docker-final/healthcheck/healthcheck.sh

#BROWSER
#HUB_HOST
#MODULE

#ENTRYPOINT java -cp selenium-docker-final.jar:selenium-docker-final-tests.jar:libs/* -DBROWSER=$BROWSER -DHUB_HOST=$HUB_HOST org.testng.TestNG $MODULE
ENTRYPOINT sh healthcheck.sh