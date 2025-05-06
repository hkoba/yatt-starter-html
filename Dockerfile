# 複数アプリ共存版
# - 複数アプリ構成をコンテナ化しようとすると、かえって手間が増えるのでおすすめしません。複数アプリは VM 上に構築することをおすすめします。
# - こちらの Dockerfile は、あくまで複数アプリ共存時の apache 設定の概念検証のための環境と考えてください

FROM httpd:2.4

WORKDIR /usr/local/apache2

RUN apt-get update && \
  apt install -y perl curl make gcc && \
  apt-get install -y locales && \
    echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    dpkg-reconfigure -f noninteractive locales && \
    /usr/sbin/update-locale LANG=ja_JP.UTF-8 && \
  apt-get clean

RUN curl -fsSL https://raw.githubusercontent.com/skaji/cpm/main/cpm > cpm && chmod +x cpm

RUN ./cpm install -g File::AddInc

COPY yatt.webapp/cpanfile yatt.webapp/cpanfile

# global install
RUN cd yatt.webapp/ && ../cpm install -g --show-build-log-on-failure

ENV LC_ALL ja_JP.UTF-8

COPY httpd-conf/httpd.conf /usr/local/apache2/conf/

COPY httpd-conf/extra/*.conf /usr/local/apache2/conf/extra/

#========================================

# http://localhost/-/
COPY yatt.webapp yatt.webapp

# http://localhost/another/-/
COPY yatt/another.webapp yatt/another.webapp

# ... 以下、好きなだけ足す

