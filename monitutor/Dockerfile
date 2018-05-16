FROM ms42q/web2py-apache2:v1.1

ENV CERT_SUBJECT="/CN=monitutor.example.com"
ENV CA_SUBJECT="/CN=Monitutor CA/O=Monitutor"


RUN rm -rf /var/www/web2py/applications/welcome && \
    rm -rf /var/www/web2py/applications/examples

RUN apt-get update && \
    apt-get install supervisor python-pip libgraphviz-dev graphviz-dev python-psycopg2 curl -y && \
    apt-get clean
RUN pip install requests pykka sqlalchemy subprocess32 pika

COPY MoniTutor /var/www/web2py/applications/MoniTutor
RUN chown -R www-data:www-data /var/www/web2py/applications

ADD ./docker_entrypoint.sh /tmp/
ADD ./supervisord.conf /etc/supervisord.conf
RUN chmod 755 /tmp/docker_entrypoint.sh

ENTRYPOINT ["bash", "/tmp/docker_entrypoint.sh"]
CMD supervisord -c /etc/supervisord.conf


