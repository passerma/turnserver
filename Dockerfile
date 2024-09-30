FROM alpine

RUN apk add make \
  gcc\
  g++ \
  git \
  libevent-dev \
  openssl-dev \
  libffi-dev \
  curl

RUN git clone https://github.com/coturn/coturn.git \
  && cd coturn \
  && ./configure && make && make install && cd .. \
  && rm -rf coturn

COPY ./start.sh /start.sh

WORKDIR /etc/

EXPOSE 3478 3478/udp

ENTRYPOINT ["/start.sh"]
