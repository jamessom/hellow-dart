FROM google/dart

WORKDIR /app

RUN apt-get update && \
    apt-get install -y \
    gcc g++ make \
    curl nodejs python \
    git software-properties-common && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs
    
RUN npm i -g nodemon

COPY pubspec.* /app/

RUN pub global activate webdev
RUN pub global activate stagehand

RUN pub get

ENV PATH="${PATH}:/usr/lib/dart/bin/"
ENV PATH="${PATH}:/root/.pub-cache/bin"

RUN pub get --offline

COPY . /app