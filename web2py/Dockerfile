FROM ms42q/web2py-apache2:1.0

RUN rm -rf /var/www/web2py/applications/welcome && \
    rm -rf /var/www/web2py/applications/examples

RUN cd /var/www/web2py/applications && \
    git clone https://github.com/its-lab/MoniTutor.git && \
    chown -R www-data:www-data /var/www/web2py/applications

RUN apt-get update && \
    apt-get install python-pip libgraphviz-dev graphviz-dev python-psycopg2 -y && \
    apt-get clean
RUN pip install requests pykka sqlalchemy subprocess32

ADD ./docker_entrypoint.sh /tmp/
RUN chmod 755 /tmp/docker_entrypoint.sh

CMD /tmp/docker_entrypoint.sh apachectl -e info -DFOREGROUND


