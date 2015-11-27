FROM ubuntu:14.04
MAINTAINER Aurelien Chaudagne <aurelien@wid.la>

RUN apt-get update && apt-get install -y dnsmasq dnsutils ca-certificates wget supervisor && apt-get clean
RUN wget https://github.com/jwilder/docker-gen/releases/download/0.4.0/docker-gen-linux-amd64-0.4.0.tar.gz
RUN tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-0.4.0.tar.gz
RUN rm /docker-gen-linux-amd64-0.4.0.tar.gz 
RUN mkdir -p /var/log/supervisor

RUN echo "addn-hosts=/home/conf/hosts" >> /etc/dnsmasq.conf
RUN echo "user=root" >> /etc/dnsmasq.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 53/udp

CMD ["/usr/bin/supervisord"]
