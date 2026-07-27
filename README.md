# Ollama Remote Client

A lightweight Debian-based Docker container that acts as a CLI client for a **remote Ollama server**. Instead of running Ollama locally, this image lets you interact with an Ollama instance hosted elsewhere on your network (e.g. a homelab server) through an interactive shell.

## Features

- 🐧 Minimal Debian 13 base image
- 🔌 Connects to any remote Ollama server via `OLLAMA_HOST`
- 🐚 Drops you into an interactive Bash shell on startup
- 🔐 Server address kept out of version control via `.env`
- 🧩 Fully configurable through Docker Compose

## Project Structure

```
.
├── Dockerfile
├── docker-compose.yml
├── .env                # local only, gitignored
├── .env.example        # template for required variables
├── scripts/            # helper scripts copied into the image
└── README.md
```

## Prerequisites

- Docker Engine
- Docker Compose v2+
- A running Ollama server reachable from this machine

## Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/your-user/ollama-remote-client.git
   cd ollama-remote-client
   ```

2. Create your local `.env` file from the example:

   ```bash
   cp .env.example .env
   ```

3. Edit `.env` with your Ollama server's address:

   ```env
   OLLAMA_SERVER=
   OLLAMA_PORT=11434
   ```

## Usage

Build and start the container with an interactive shell:

```bash
docker compose up -d
docker compose exec ollama-client bash
```

Or run it directly in the foreground:

```bash
docker compose run --rm ollama-client
```

Once inside the container, verify the connection to your remote server:

```bash
ollama list
```

## Configuration

| Variable        | Description                          | Example                     |
|-----------------|---------------------------------------|------------------------------|
| `OLLAMA_SERVER` | Hostname or IP of the remote server   | `ollama-server.ravenloft`   |
| `OLLAMA_PORT`   | Port the remote Ollama API listens on | `11434`                      |

These variables are combined into `OLLAMA_HOST` and injected into the container at runtime via Docker Compose, overriding the default defined in the `Dockerfile`.

## Security Notes

- The `.env` file is excluded from version control via `.gitignore` — never commit real server addresses or credentials.
- Only `.env.example` (with placeholder values) should be tracked in Git.

## License

MIT
