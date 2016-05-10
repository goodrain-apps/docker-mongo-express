FROM node:5.6-slim

EXPOSE 8081

ENV MONGO_EXPRESS 0.30.54

RUN npm install mongo-express@$MONGO_EXPRESS

WORKDIR /node_modules/mongo-express

RUN cp config.default.js config.js

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh && \
    chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["node", "app"]
