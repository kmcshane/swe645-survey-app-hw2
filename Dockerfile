# Karen McShane
# This is the Dockerfile for my survey application. I chose to deploy it with nginx
FROM nginx:alpine

COPY ./html /usr/share/nginx/html