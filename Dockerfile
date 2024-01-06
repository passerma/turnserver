FROM alpine

RUN apk add make \
  gcc\
  g++ \
  wget \
  libevent-dev \
  openssl-dev \
  libffi-dev \
  curl

RUN wget https://github.com/coturn/coturn/archive/4.5.1.3.tar.gz \
  && tar -zxvf 4.5.1.3.tar.gz \
  && cd coturn-4.5.1.3 \
  && ./configure && make && make install && cd .. \
  && rm -rf coturn-4.5.1.3 4.5.1.3.tar.gz

COPY ./start.sh /start.sh

EXPOSE 3478 3478/udp

ENTRYPOINT ["/start.sh"]
