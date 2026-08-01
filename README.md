# Ollama Remote Client

A lightweight Debian-based Docker image that works as a CLI client for a **remote Ollama server**. Instead of hosting models locally, this container connects to an existing Ollama instance over the network through the `OLLAMA_HOST` environment variable.

## Features

- Debian 13 base image
- Remote Ollama endpoint support via `OLLAMA_HOST`
- Ready to use with Docker Compose
- Interactive Bash shell workflow
- Local environment configuration with `.env`
- Suitable for homelab and remote inference setups

## Image on Docker Hub

The prebuilt image is available on Docker Hub:

- [`weldias/ollama-remote-client`](https://hub.docker.com/r/weldias/ollama-remote-client)

You can either **pull and run the published image** or **build it locally from this repository**.

## Quick Start with Docker Hub

### 1. Pull the image

```bash
docker pull weldias/ollama-remote-client:latest
```

### 2. Run it with a remote Ollama server

```bash
docker run -it --rm   -e OLLAMA_HOST=http://your-ollama-server:11434   weldias/ollama-remote-client:latest
```

That opens a shell inside the container with `OLLAMA_HOST` already configured for the remote server.

### 3. Test connectivity

Once inside the container:

```bash
ollama --version
ollama list
```

If the remote server is reachable, `ollama list` should return the models available on that server.

## Quick Start with Docker Compose

Create a `docker-compose.yml` like this:

```yaml
services:
  ollama-client:
    image: weldias/ollama-remote-client:latest
    container_name: ollama-client
    environment:
      OLLAMA_HOST: http://${OLLAMA_SERVER}:${OLLAMA_PORT}
    stdin_open: true
    tty: true
    entrypoint: ["/bin/bash"]
```

Create a local `.env` file:

```env
OLLAMA_SERVER=ADDRESS-OF-YOUR-OLLAMA-SERVER
OLLAMA_PORT=11434
```

Start the container:

```bash
docker compose up -d
docker compose exec ollama-client bash
```

Or run it in the foreground:

```bash
docker compose run --rm ollama-client
```

## Build from Source

If you prefer to build the image yourself:

```bash
git clone https://github.com/your-user/ollama-remote-client.git
cd ollama-remote-client
docker compose build
```

Example compose file for local builds:

```yaml
services:
  ollama-client:
    build:
      context: .
      dockerfile: Dockerfile
    image: ollama-client:latest
    container_name: ollama-client
    environment:
      OLLAMA_HOST: http://${OLLAMA_SERVER}:${OLLAMA_PORT}
    stdin_open: true
    tty: true
    entrypoint: ["/bin/bash"]
```

## Configuration

| Variable | Description | Example |
|---|---|---|
| `OLLAMA_HOST` | Full URL of the remote Ollama server | `http://ollama-server.ravenloft:11434` |
| `OLLAMA_SERVER` | Hostname or IP used by Docker Compose | `ollama-server.ravenloft` |
| `OLLAMA_PORT` | Port used by Docker Compose | `11434` |

When using Docker Compose, `OLLAMA_SERVER` and `OLLAMA_PORT` are combined into `OLLAMA_HOST` at runtime.

## Project Structure

```text
.
├── Dockerfile
├── docker-compose.yml
├── .env.example
├── scripts/
└── README.md
```

## Git Notes

Recommended `.gitignore` entries:

```gitignore
.env
.env.*
!.env.example
```

This keeps local server addresses and other machine-specific values out of version control while preserving a tracked example file.

## Common Commands

Inside the container, useful commands include:

```bash
ollama --version
ollama list
ollama show llama3
```

Replace `llama3` with a model that exists on your remote Ollama server.

## License

MIT
