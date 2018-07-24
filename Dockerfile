FROM frolvlad/alpine-glibc:latest

LABEL maintainer="Jeffery Bagirimvano"

ENV OC_VERSION=v3.9.0 \
    OC_TAG_SHA=191fece \
    S2I_VERSION='1.1.10' \
    S2I_TAG_SHA='27f0729d' \
    BUILD_DEPS='tar gzip' \
    RUN_DEPS='curl ca-certificates gettext ansible git bash'

RUN apk --no-cache add $BUILD_DEPS $RUN_DEPS && \
    curl -sLo /tmp/oc.tar.gz https://github.com/openshift/origin/releases/download/${OC_VERSION}/openshift-origin-client-tools-${OC_VERSION}-${OC_TAG_SHA}-linux-64bit.tar.gz && \
    tar xzvf /tmp/oc.tar.gz -C /tmp/ && \
    mv /tmp/openshift-origin-client-tools-${OC_VERSION}-${OC_TAG_SHA}-linux-64bit/oc /usr/local/bin/ && \
    curl -sLo /tmp/s2i.tar.gz https://github.com/openshift/source-to-image/releases/download/v${S2I_VERSION}/source-to-image-v${S2I_VERSION}-${S2I_TAG_SHA}-linux-amd64.tar.gz && \
    tar xzvf /tmp/s2i.tar.gz -C /usr/local/bin/ && \
    rm -rf /tmp/oc.tar.gz /tmp/s2i.tar.gz /tmp/openshift-origin-client-tools-${OC_VERSION}-${OC_TAG_SHA}-linux-64bit && \
    apk del $BUILD_DEPS

CMD ["/usr/local/bin/oc"]

