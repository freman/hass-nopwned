ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

# Copy data for add-on
COPY app /app
RUN apk add --no-cache \
	docker-cli; \
	chmod a+x /app/run.sh

CMD [ "/app/run.sh" ]

