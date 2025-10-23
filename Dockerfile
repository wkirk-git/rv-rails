FROM debian:trixie-slim
SHELL ["/bin/bash", "-c"]
RUN apt-get update -y
RUN apt-get install -y curl xz-utils make gcc git libyaml-dev
RUN useradd -ms /bin/bash rails
USER rails
WORKDIR /home/rails/
RUN curl --proto '=https' --tlsv1.2 -LsSf https://github.com/spinel-coop/rv/releases/download/v0.2.0/rv-installer.sh | sh
ENV PATH="$PATH:/home/rails/.cargo/bin:/home/rails/.data/rv/rubies/ruby-3.4.7/bin"
RUN echo 'eval "$(rv shell init bash)"' >> ~/.bashrc
ENV BASH_ENV="/home/rails/.bashrc"
RUN rv ruby install 3.4.7
RUN rv ruby pin ruby-3.4.7
RUN gem update --system 3.7.2
RUN gem install rails
RUN rails new app
ENTRYPOINT ["./app/bin/rails", "s", "-b", "0.0.0.0"]
