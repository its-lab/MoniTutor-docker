FROM python:2

ENV DATABASE_HOST=db
ENV DATABASE_NAME=monitutor
ENV DATABASE_USER=monitutor
ENV DATABASE_PASSWORD=admin

WORKDIR /usr/src/app/MoniTutor-Tunnel

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY entrypoint.sh ./
RUN chmod 755 ./entrypoint.sh

COPY MoniTutor-Tunnel /usr/src/app/MoniTutor-Tunnel

ENTRYPOINT [ "./entrypoint.sh" ]
CMD ["python", "./start_server.py", "-vvv"]
