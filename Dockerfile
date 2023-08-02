FROM node:18-slim 

WORKDIR /src

RUN \
    DEBIAN_FRONTEND=noninteractive apt update && \
    apt install -y --no-install-recommends build-essential python3-pip

COPY package.json .

# https://mediasoup.org/documentation/v3/mediasoup/installation/
ENV MEDIASOUP_SKIP_WORKER_PREBUILT_DOWNLOAD="true"

RUN npm install

COPY app app
COPY public public
CMD ufw status

CMD ufw allow 3010/tcp
CMD ufw allow 40000:40100/tcp
CMD ufw allow 40000:40100/udp

CMD ufw allow 22/tcp
CMD ufw allow 80/tcp
CMD ufw allow 443/udp

CMD ufw enable
CMD npm start
