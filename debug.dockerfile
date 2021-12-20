FROM ubuntu
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN	apt-get update && \
    apt-get -y -q install \
        openssh-server \
        make \
        ca-certificates \
        gnupg-agent \
        curl

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
          "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) \
          stable"

RUN	apt-get update && \
  apt-get -y -q install \
    docker-ce-cli

