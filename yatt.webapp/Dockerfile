# シングルアプリ版

#========================================
FROM httpd:2.4 AS builder

WORKDIR /yatt.webapp

RUN apt update && apt install -y perl curl make gcc

RUN curl -fsSL https://raw.githubusercontent.com/skaji/cpm/main/cpm > cpm && chmod +x cpm

RUN ./cpm install -g File::AddInc

COPY cpanfile ./

# local install
RUN ./cpm install --show-build-log-on-failure

#========================================
FROM httpd:2.4

WORKDIR /usr/local/apache2/yatt.webapp

RUN apt-get update && \
  apt install -y perl && \
  apt-get install -y locales && \
    echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    dpkg-reconfigure -f noninteractive locales && \
    /usr/sbin/update-locale LANG=ja_JP.UTF-8 && \
  apt-get clean

ENV LC_ALL ja_JP.UTF-8

COPY httpd-conf/httpd.conf /usr/local/apache2/conf/

COPY httpd-conf/extra/*.conf /usr/local/apache2/conf/extra/

COPY --from=builder /yatt.webapp .

# --parents 使いたいが…
COPY cpanfile app.psgi ./
COPY public ./public
COPY cgi-bin ./cgi-bin

# VOLUME ["/usr/local/apache2/yatt.webapp/var"]
