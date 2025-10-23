FROM debian:trixie-20251020-slim
SHELL ["/bin/bash", "-exo", "pipefail",  "-c"]
RUN apt-get update -y && \
apt-get install -y curl=8.14.1-2 xz-utils=5.8.1-1 make=4.4.1-2 gcc=4:14.2.0-1 git=1:2.47.3-0+deb13u1 libyaml-dev=0.2.5-2 && \
rm -rf /var/lib/apt/lists/* && \
useradd -ms /bin/bash rails
USER rails
WORKDIR /home/rails/
ENV PATH="$PATH:/home/rails/.cargo/bin:/home/rails/.data/rv/rubies/ruby-3.4.7/bin"
ENV BASH_ENV="/home/rails/.bashrc"
RUN echo "eval \"$(rv shell init bash)\"" >> ~/.bashrc && \
curl --proto '=https' --tlsv1.2 -LsSf https://github.com/spinel-coop/rv/releases/download/v0.2.0/rv-installer.sh | sh && \
rv ruby install 3.4.7 && \
rv ruby pin ruby-3.4.7 && \
gem update --system 3.7.2 && \
gem install rails --version 8.1.0 && \
rails new app
ENTRYPOINT ["./app/bin/rails", "s", "-b", "0.0.0.0"]
