FROM gites/kube-ops-view:0.7.1.5
MAINTAINER Tomasz Pawelczak <tomasz@pawelczak.eu>

EXPOSE 8080

#####RUN apk add --no-cache python3 python3-dev gcc musl-dev zlib-dev libffi-dev openssl-dev ca-certificates && \
#####    python3 -m ensurepip && \
#####    rm -r /usr/lib/python*/ensurepip && \
#####    pip3 install --upgrade pip setuptools gevent && \
#####    apk del python3-dev gcc musl-dev zlib-dev libffi-dev openssl-dev && \
#####    rm -rf /var/cache/apk/* /root/.cache /tmp/* 

RUN rm -rf /kube_ops_view/static/build/*js

COPY scm-source.json /

#####COPY requirements.txt /
#####RUN pip3 install -r /requirements.txt

COPY kube_ops_view /kube_ops_view

ARG VERSION=dev
RUN sed -i "s/__version__ = .*/__version__ = '${VERSION}'/" /kube_ops_view/__init__.py

WORKDIR /
ENTRYPOINT ["/usr/bin/python3", "-m", "kube_ops_view"]
