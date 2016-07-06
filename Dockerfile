FROM node:5.6-slim


# timezone
RUN echo "Asia/Shanghai" > /etc/timezone;dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update && apt-get install -y netcat-openbsd &&\
    rm -rf /var/lib/apt/lists/*
ENV MONGO_EXPRESS 0.30.59

RUN npm install mongo-express@$MONGO_EXPRESS

WORKDIR /node_modules/mongo-express

RUN cp config.default.js config.js

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 8081

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["node", "app"]
