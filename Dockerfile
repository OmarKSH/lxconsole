FROM alpine:3.20.2

RUN apk add --no-cache py3-pip sqlite

RUN mkdir -p /opt/lxconsole

COPY requirements.txt /opt/lxconsole/requirements.txt
RUN python3 -m venv /opt/lxconsole
RUN /opt/lxconsole/bin/pip install --upgrade pip
RUN /opt/lxconsole/bin/pip3 install -r /opt/lxconsole/requirements.txt

ADD lxconsole /opt/lxconsole/lxconsole
COPY run.py /opt/lxconsole/run.py

WORKDIR /opt/lxconsole

#ENTRYPOINT [ "gunicorn" ]
#CMD [ "--bind", "0.0.0.0:8081", "run:app" ]

#ENTRYPOINT [ "python3" ]
#CMD [ "run.py", "--host", "0.0.0.0", "--port", "5000"]

ENTRYPOINT [ "/opt/lxconsole/bin/python3" ]
CMD [ "run.py" ]
