DEV_BUILD_NUMBER=$(date '+%Y%m%d%H%M')
GO_VERSION=17
docker build -f bedev.dockerfile -t theotw/devstack .
docker tag theotw/devstack:latest theotw/devstack:go_$GO_VERSION
