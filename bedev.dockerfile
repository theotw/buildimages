FROM ubuntu
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN	apt-get update && \
    apt-get -y -q install curl \
        make \
        openjdk-11-jdk \
        git \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common \
        openssh-server \
        iputils-ping \
        vim


RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
          "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) \
          stable"

RUN curl https://baltocdn.com/helm/signing.asc | apt-key add -
RUN apt-get install apt-transport-https --yes
RUN echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list

RUN	apt-get update && \
  apt-get -y -q install \
    docker-ce-cli \
    helm

RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.2/bin/linux/amd64/kubectl"
RUN chmod +x kubectl
RUN cp kubectl /usr/local/bin/

COPY . .
RUN cp sshd_config /etc/ssh/
RUN cp shadow /etc
RUN update-rc.d ssh defaults
ARG GOVERSION=go1.15.12.linux-amd64.tar.gz
RUN curl -O https://storage.googleapis.com/golang/$GOVERSION && tar -C /usr/local -xzf $GOVERSION
RUN echo "export PATH=$PATH:/usr/local/go/bin/" >>/etc/profile
RUN echo PATH="/usr/local/go/bin/:/root/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/go/bin/" >/etc/environment
RUN echo PATH=/usr/local/go/bin/:/root/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/go/bin/$PATH >>/root/.profile
RUN echo PATH=/usr/local/go/bin/:/root/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/go/bin/$PATH >>/root/.bashrc



