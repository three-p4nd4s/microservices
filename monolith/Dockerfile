FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gnupg \
    curl \
    ca-certificates && \
    curl -fsSL https://www.mongodb.org/static/pgp/server-6.0.asc | gpg --dearmor -o /usr/share/keyrings/mongodb-server-6.0.gpg && \
    echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] http://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    mongodb-org-server \
    ruby \
    ruby-dev \
    build-essential \
    git && \
    rm -rf /var/lib/apt/lists/*

RUN gem install bundler

RUN git clone https://github.com/Artemmkin/reddit.git && \
    rm /reddit/Gemfile.lock

COPY mongod.conf /etc/mongod.conf
COPY db_config /reddit/db_config
COPY start.sh /start.sh
COPY Gemfile /reddit/Gemfile
COPY vendor /reddit/vendor

RUN cd /reddit && bundle install --local
RUN mkdir -p /data/db
RUN chmod 0777 /start.sh

CMD ["/start.sh"]
