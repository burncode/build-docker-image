FROM jeanblanchard/busybox-java:8
ADD $JAR_FILE /
ADD start-app.sh /
WORKDIR /
EXPOSE 8000
VOLUME ["/logs"]
ENTRYPOINT ["/start-app.sh"]
