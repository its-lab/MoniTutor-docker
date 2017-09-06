FROM python:2

RUN mkdir /usr/src/app \
    && cd /usr/src/app \
    && git clone https://github.com/its-lab/MoniTutor-Tunnel.git \
    && rm -rf MoniTutor-Tunnel/.git \
    && cd MoniTutor-Tunnel

ENV DATABASE_HOST=db
ENV DATABASE_NAME=monitutor
ENV DATABASE_USER=monitutor
ENV DATABASE_PASSWORD=admin

WORKDIR /usr/src/app/MoniTutor-Tunnel

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY entrypoint.sh ./
RUN chmod 755 ./entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh", "python", "./server.py" ]
CMD ["-v"]
