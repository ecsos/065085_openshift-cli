FROM frolvlad/alpine-glibc:latest

LABEL maintainer="Nick Salonen <whatdoyouwant@gmail.com>"

ENV OC_VERSION=v3.11.0 \
    OC_TAG_SHA=0cbc58b \
    BUILD_DEPS='tar gzip' \
    RUN_DEPS='curl ca-certificates gettext ansible git bash py-dnspython'

RUN apk --no-cache add $BUILD_DEPS $RUN_DEPS && \
    apk --no-cache add py3-jmespath --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ && \
    curl -sLo /tmp/oc.tar.gz https://github.com/openshift/origin/releases/download/${OC_VERSION}/openshift-origin-client-tools-${OC_VERSION}-${OC_TAG_SHA}-linux-64bit.tar.gz && \
    tar xzvf /tmp/oc.tar.gz -C /tmp/ && \
    mv /tmp/openshift-origin-client-tools-${OC_VERSION}-${OC_TAG_SHA}-linux-64bit/oc /usr/local/bin/ && \
    mv /tmp/openshift-origin-client-tools-${OC_VERSION}-${OC_TAG_SHA}-linux-64bit/kubectl /usr/local/bin/ && \
    rm -rf /tmp/oc.tar.gz /tmp/openshift-origin-client-tools-${OC_VERSION}-${OC_TAG_SHA}-linux-64bit && \
    mkdir -p /etc/ansible && \
    echo "[defaults]" > /etc/ansible/ansible.cfg && \
    echo "# human-readable stdout/stderr results display" >> /etc/ansible/ansible.cfg && \
    echo "stdout_callback = yaml" >> /etc/ansible/ansible.cfg && \
    apk del $BUILD_DEPS

CMD ["/usr/local/bin/oc"]

