# 베이스 이미지 설정
FROM nginx:alpine

WORKDIR /usr/share/nginx/html
RUN mkdir images
COPY docker.png images/docker.png
COPY my.html .
EXPOSE 8080
ENTRYPOINT ["nginx", "-g", "daemon off;"]
