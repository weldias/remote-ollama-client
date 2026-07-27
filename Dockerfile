FROM debian:13

# variável de endereço do servidor remoto
ARG DEFAULT_OLLAMA_HOST=http://OLLAMA-SERVER-ADDRESS:OLLAMA-SERVER-PORT
ENV OLLAMA_HOST=${DEFAULT_OLLAMA_HOST}

# atualiza o sistema base
RUN apt update && apt upgrade -y && rm -rf /var/lib/apt/lists/*

# instala as dependencias necessárias
RUN apt update && apt install -y curl zstd && rm -rf /var/lib/apt/lists/*

# instala o ollama
RUN mkdir -p /opt/ollama
WORKDIR /opt/ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# copia os helper scripts
COPY ./scripts /opt/ollama/scripts

CMD [ "ollama", "--version" ]
