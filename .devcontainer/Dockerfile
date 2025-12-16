FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends \
  ca-certificates curl git \
  && rm -rf /var/lib/apt/lists/*