FROM ubuntu
MAINTAINER liuzheng712@gmail.com

ENV DEBIAN_FRONTEND=noninteractive
ENV APP=''

RUN set -xe \
    && apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl \
    xvfb x11vnc xterm \
    sudo \
    supervisor \
    libcups2 libglib2.0-0 libglib2.0-data libglu1-mesa libicu60 libxml2 shared-mime-info xdg-user-dirs \
    xdg-utils --fix-missing \
    gnupg && \
    curl -o wps.deb https://wdl1.cache.wps.cn/wps/download/ep/Linux2019/8722/wps-office_11.1.0.8722_amd64.deb && \
    dpkg -i wps.deb &&\
    rm -f wps.deb && \
    rm -rf /var/lib/apt/lists/*

RUN set -xe \
    && useradd -u 1000 -g 100 -G sudo --shell /bin/bash --no-create-home --home-dir /tmp user \
    && echo 'ALL ALL = (ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

COPY supervisord.conf /etc/
COPY entry.sh /

User user
WORKDIR /tmp

CMD ["/entry.sh"]
