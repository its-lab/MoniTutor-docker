FROM debian:stretch

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    lsb-release \
    gnupg \
    wget  \
    supervisor \
    && apt-get clean

RUN export DEBIAN_FRONTEND=noninteractive \
    && curl https://packages.icinga.com/icinga.key | apt-key add - \
    && echo "deb http://packages.icinga.org/debian icinga-$(lsb_release -cs) main" > /etc/apt/sources.list.d/icinga2.list \
    && apt-get update \
    && apt-get install -y \
        icinga2 \
        icinga2-ido-pgsql \
    && apt-get clean

COPY container /container 
RUN mv /container/supervisor.conf /etc/supervisor.conf \
    && chmod 755 /container/entrypoint.sh \
    && chmod 755 /container/start_icinga2.sh

ENV ICINGA2_DATABASE_PASSWORD=icinga2
ENV ICINGA2_DATABASE_USERNAME=icinga2
ENV ICINGA2_DATABASE_NAME=icinga2
ENV ICINGA2_API_USERNAME=icinga2-api
ENV ICINGA2_API_PASSWORD=icinga2-api
ENV ICINGA2_DATABASE_HOST=db

ENTRYPOINT ["/container/entrypoint.sh"]
CMD supervisord -c /etc/supervisor.conf
