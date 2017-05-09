FROM ubuntu:precise
ADD fastpath /usr/bin
RUN useradd -m -s /bin/bash fastpath && mkdir /data && chown fastpath /data
USER fastpath
WORKDIR /data
ENV HOME=/home/fastpath
ENTRYPOINT /usr/bin/fastpath