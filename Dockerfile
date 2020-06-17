FROM debian:buster

RUN \
    sed -i s/deb.debian.org/mirrors.cqu.edu.cn/ /etc/apt/sources.list \
    && \
    apt-get update \
    && \
    apt-get \ 
        install -y --no-install-recommends --no-install-suggests \
        libgtk2.0-0 \
        libx11-xcb1 \
        libxtst6 \
        libnss3 \
        libasound2 \
        libdbus-glib-1-2 \
        iptables xclip \
        dante-server \
        tigervnc-standalone-server \
        tigervnc-common \
        psmisc \
        flwm \
        x11-utils \
        tinyproxy \
        busybox

RUN \
    busybox \
        wget "http://download.sangfor.com.cn/download/product/sslvpn/pkg/linux_01/EasyConnect_x64.deb" \
            -O "/tmp/EasyConnect.deb" \
    && \
    dpkg -i "/tmp/EasyConnect.deb" \
    && \
    rm "/tmp/EasyConnect.deb" \
    && \
    apt-get purge -y busybox --auto-remove

COPY ./docker-root /

#ENV TYPE="" PASSWORD="" LOOP=""
#ENV DISPLAY

VOLUME /root/

CMD ["start.sh"]
