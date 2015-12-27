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

COPY config.json /srv/inbox/config.json
COPY secrets.yml /srv/inbox/secrets.yml
COPY entrypoint.sh /entrypoint.sh
ENV INBOX_CFG_PATH /srv/inbox/config.json:/srv/inbox/secrets.yml

EXPOSE 5555

# grab gosu for easy step-down from root
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture)" \
	&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture).asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu

VOLUME "/var/lib/inboxapp"
ENTRYPOINT [ "/entrypoint.sh" ]
