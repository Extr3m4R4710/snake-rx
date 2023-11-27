FROM alpine
RUN apk update && apk add curl
COPY snake-rx.sh . 
RUN chmod 755 ./snake2x.sh
ENTRYPOINT ["./snake2x.sh"]
