FROM node:15-slim

RUN apt update && apt dist-upgrade -y && \
  apt install -y wget gnupg2 && \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list && \
  apt-get update && apt-get -y install google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1

WORKDIR /srv

COPY package.json ./
COPY package-lock.json ./

RUN npm install

COPY . .

RUN npm run build 

RUN rm -Rf /tmp/*
RUN rm -Rf /var/lib/apt/lists/*

ENV NODE_ENV production

CMD ["npm", "start"]