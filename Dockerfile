FROM debian:trixie-20251208-slim
LABEL maintainer="William Kirk wkirk-git@mailbox.org" \
      org.opencontainers.image.authors="William Kirk wkirk-git@mailbox.org" \
      description="This project https://github.com/wkirk-git/rv-rails demonstrates using the rv package manager to set up a Ruby development environment with Rails 8.1.0 in a slim Debian Trixie container." \
      version="0.2.0"
SHELL ["/bin/bash", "-exo", "pipefail",  "-c"]
RUN apt-get update -y && \
apt-get install --no-install-recommends -y \
curl=8.14.1-2+deb13u2 \
xz-utils=5.8.1-1 \
build-essential=12.12 \
ca-certificates=20250419 \
git=1:2.47.3-0+deb13u1 \
libyaml-dev=0.2.5-2 && \
rm -rf /var/lib/apt/lists/* && \
useradd -ms /bin/bash rails
USER rails
WORKDIR /home/rails/
ENV PATH="$PATH:/home/rails/.cargo/bin:/home/rails/.data/rv/rubies/ruby-3.4.7/bin"
ENV BASH_ENV="/home/rails/.bashrc"
RUN echo "eval \"$(rv shell init bash)\"" >> ~/.bashrc && \
curl --proto '=https' --tlsv1.2 -LsSf https://github.com/spinel-coop/rv/releases/download/v0.3.0/rv-installer.sh | sh && \
rv ruby install 3.4.7 && \
rv ruby pin ruby-3.4.7 && \
gem update --system 3.7.2 && \
gem install rails --version 8.1.1 && \
rails new app
EXPOSE 3000
ENTRYPOINT ["./app/bin/rails", "s", "-b", "0.0.0.0"]
