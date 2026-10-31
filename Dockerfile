# Document:
# https://github.com/picoruby/prk_firmware/wiki/Docker

FROM --platform=amd64 ubuntu:24.04 AS build

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  ca-certificates \
  cmake \
  gcc-arm-none-eabi \
  git \
  libnewlib-arm-none-eabi \
  libstdc++-arm-none-eabi-newlib \
  python3 \
  rake \
  ruby \
  ruby-bundler \
  ruby-dev \
  zip \
  && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/raspberrypi/pico-sdk.git -b 2.3.0
RUN cd /pico-sdk && git submodule update --init lib/tinyusb
ENV PICO_SDK_PATH="/pico-sdk"

ENV PRK_HOME=/prk_firmware
VOLUME "${PRK_HOME}"
WORKDIR "${PRK_HOME}"
COPY . .
RUN rake setup
RUN git config --global --add safe.directory '*'
