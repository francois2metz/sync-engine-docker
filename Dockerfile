FROM ubuntu:precise

RUN apt-get -q update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qy install \
        git \
        mercurial \
        wget \
        python \
        python-dev \
        python-pip \
        python-setuptools \
        build-essential \
        libmysqlclient-dev \
        gcc \
        g++ \
        libzmq-dev \
        libxml2-dev \
        libxslt-dev \
        lib32z1-dev \
        libffi-dev \
        pkg-config \
        python-lxml \
        tmux \
        curl \
        tnef

RUN pip install 'pip>=1.5.6' 'setuptools>=5.3'

RUN useradd -ms /bin/sh admin && \
    install -d -m0775 -o root -g admin /srv/inbox

WORKDIR /srv/inbox

RUN git clone https://github.com/nylas/sync-engine.git /srv/inbox
RUN pip install -r requirements.txt
RUN pip install -e .

COPY docker/ /srv/
COPY config.json /srv/inbox/config.json
COPY secrets.yml /srv/inbox/secrets.yml

ENV INBOX_CFG_PATH /srv/inbox/config.json:/srv/inbox/secrets.yml

EXPOSE 5555
USER admin

VOLUME "/var/lib/inboxapp"
