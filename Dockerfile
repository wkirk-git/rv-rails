FROM debian:trixie-slim
SHELL ["/bin/bash", "-c"]
RUN apt-get update -y && \
apt-get install -y curl xz-utils make gcc git libyaml-dev && \
rm -rf /var/lib/apt/lists/* && \
useradd -ms /bin/bash rails
USER rails
WORKDIR /home/rails/
ENV PATH="$PATH:/home/rails/.cargo/bin:/home/rails/.data/rv/rubies/ruby-3.4.7/bin"
ENV BASH_ENV="/home/rails/.bashrc"
RUN echo 'eval "$(rv shell init bash)"' >> ~/.bashrc && \
curl --proto '=https' --tlsv1.2 -LsSf https://github.com/spinel-coop/rv/releases/download/v0.2.0/rv-installer.sh | sh && \
rv ruby install 3.4.7 && \
rv ruby pin ruby-3.4.7 && \
gem update --system 3.7.2 && \
gem install rails && \
rails new app
ENTRYPOINT ["./app/bin/rails", "s", "-b", "0.0.0.0"]
