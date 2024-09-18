FROM node:16.16.0
ENV PYTHONUNBUFFERED=1
RUN apt-get update && apt-get install python3 python3-pip unzip -y &&  rm -rf /var/lib/apt/lists/*
ARG GIT_VERSION=main

ADD https://github.com/ZiganshinIB/star-burger-dvmn/archive/refs/heads/${GIT_VERSION}.zip  /opt/star-burger-dvmn.zip
WORKDIR /opt
RUN unzip star-burger-dvmn.zip && \
    mv star-burger-dvmn-${GIT_VERSION} star-burger && \
    rm star-burger-dvmn.zip

WORKDIR /opt/star-burger
RUN npm ci --dev && ./node_modules/.bin/parcel build bundles-src/index.js --dist-dir bundles --public-url="./" && pip3 install -r requirements.txt
EXPOSE 8000
CMD ["sh", "-c", "python3 manage.py collectstatic --no-input && python3 manage.py migrate && python3 manage.py runserver 0.0.0.0:8000"]
