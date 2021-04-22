FROM debian:buster

RUN apt-get update \
 && apt-get install -y --no-install-recommends apt-transport-https gnupg ca-certificates

RUN echo "deb https://packages.inverse.ca/SOGo/nightly/5/debian/ buster buster" > /etc/apt/sources.list.d/sogo.list \
 && apt-key adv --keyserver hkp://keys.gnupg.net --recv-key FE9E84327B18FF82B0378B6719CDA6A9810273C4 \
 && apt-get update \
 && apt-get install -y --no-install-recommends sogo sope4.9-gdl1-postgresql sope4.9-gdl1-mysql cron apache2 

RUN a2enmod headers proxy proxy_http rewrite ssl

USER "sogo"

ENV PREFORK=3

CMD [ "/usr/sbin/sogod", "-WOUseWatchDog", "NO", "-WOLogFile", "-", "-WONoDetach", "YES", "-WOWorkersCount", "${PREFORK}"]

