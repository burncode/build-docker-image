FROM jeanblanchard/busybox-java:8
ADD $JAR_FILE /
ADD start-app.sh /
WORKDIR /
RUN chmod +x /start-app.sh
VOLUME ["/logs"]
CMD ./start-app.sh
