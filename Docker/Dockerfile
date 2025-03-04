FROM python:2.7-slim
WORKDIR /app
ADD . /app
RUN pip install --trusted-host pypi.python.org Flask
ENV NAME World
CMD ["python", "app.py"]


#Multi stage docker image

FROM node:16 as build
WORKDIR /app
COPY package.json index.js env ./
RUN npm install

FROM node:alpine as main
COPY --from=build /app /
EXPOSE 8080
CMD ["index.js"]