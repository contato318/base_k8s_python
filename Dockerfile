FROM docker:29.0.2-dind


RUN echo "**** install gcc, make ****" && \
    apk add --no-cache gcc make python3-dev musl-dev && \
    echo "**** install Python ****" && \
    apk add --no-cache python3 py3-pip helm yq git wget curl && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    if [ ! -e /usr/bin/pip ]; then ln -sf pip3 /usr/bin/pip ; fi && \
    pip install --no-cache --upgrade --break-system-packages pip setuptools wheel && \
    pip install --no-cache --break-system-packages docker-compose && \
    echo "**** install gcloud cli ****" && \
    wget -q https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-469.0.0-linux-x86_64.tar.gz && \
    tar -xzf google-cloud-cli-*.tar.gz -C /tmp && \
    /tmp/google-cloud-sdk/install.sh --quiet && \
    rm -rf /tmp/google-cloud-sdk google-cloud-cli-*.tar.gz

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl
RUN mkdir -p $HOME/.kube

