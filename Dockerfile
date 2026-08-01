FROM debian:13

# remote server address
ARG DEFAULT_OLLAMA_HOST=http://OLLAMA-SERVER-ADDRESS:OLLAMA-SERVER-PORT
ENV OLLAMA_HOST=${DEFAULT_OLLAMA_HOST}

# update base system
RUN apt update && apt upgrade -y && rm -rf /var/lib/apt/lists/*

# install dependencies
RUN apt update && apt install -y curl zstd && rm -rf /var/lib/apt/lists/*

# install ollama
RUN mkdir -p /opt/ollama
WORKDIR /opt/ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# copy helper scripts
COPY ./scripts /opt/ollama/scripts

CMD [ "ollama", "--version" ]
