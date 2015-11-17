FROM jeanblanchard/busybox-java:8
ADD $JAR_FILE /
ADD start-app.sh /
WORKDIR /
RUN ls -l /
RUN chmod +x /start-app.sh
EXPOSE 8000
VOLUME ["/logs"]
CMD ./start-app.sh
