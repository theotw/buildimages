DEV_BUILD_NUMBER=$(date '+%Y%m%d%H%M')
GO_VERSION=go1.18.1
docker build --build-arg goversion=${GO_VERSION} -f bedev.dockerfile -t theotw/devstack .
docker tag theotw/devstack:latest theotw/devstack:$GO_VERSION
