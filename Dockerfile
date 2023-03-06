FROM docker:dind


RUN echo "**** install gcc, make ****" && \
    apk add --no-cache gcc make python3-dev musl-dev && \
    echo "**** install Python ****" && \
    apk add --no-cache python3 helm yq git && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip || echo OK && \
    rm -r /usr/lib/python*/ensurepip || echo OK && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    echo "**** install curl and git ****" && \
    apk add --no-cache git curl && \
    pip install --no-cache --upgrade docker-compose

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl
RUN mkdir -p $HOME/.kube

