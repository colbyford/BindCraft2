FROM nvidia/cuda:12.4.1-cudnn-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
	PYTHONUNBUFFERED=1 \
	PIP_NO_CACHE_DIR=1

WORKDIR /opt/BindCraft

RUN apt-get update && apt-get install -y --no-install-recommends \
		bash \
		ca-certificates \
		git \
		wget \
		curl \
		bzip2 \
		build-essential \
		python3 \
		python3-pip \
		python3-venv \
	&& rm -rf /var/lib/apt/lists/*

COPY . .

RUN chmod +x install.sh \
	&& ./install.sh

RUN python3 -m pip install --upgrade pip \
	&& python3 -m pip install .

ENTRYPOINT ["python3", "-m", "bindcraft"]
