FROM node:5.6-slim

ENV MONGO_EXPRESS 0.30.54

# timezone
RUN echo "Asia/Shanghai" > /etc/timezone;dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update && apt-get install -y netcat-openbsd &&\
    rm -rf /var/lib/apt/lists/*

RUN npm install mongo-express@$MONGO_EXPRESS


RUN cp config.default.js config.js

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

WORKDIR /node_modules/mongo-express

EXPOSE 8081

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["node", "app"]
