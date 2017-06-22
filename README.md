## Why we need docker supervisor?

Sometimes we use our docker to start our own services, but when docker restart, we have to get into our dockers to start 
the services by hand.

The docker supervisor will help us to solve this problem, after using docker supervisor, our services will alse restart when 
docker restart.

This README will show u how to use the supervisor to predict the services in your docker by the example of frpc service.

## docker-compose.yml
```
version: '2'
services:
  sx-ubuntu:
    image: sx/ubuntu14.04:3.7.b
    container_name: hzy_ubuntu
    restart: always
    tty: true
    ports:
      - "8110:8888"
      - "8111:8889"
    devices:
      - /dev/nvidia0
    volumes:
      - ~/hzy/dl-data:/root/dl-data
      - ~/sxwl-dataset:/root/sxwl-dataset
```

## Dockerfile
```
FROM sx/ubuntu14.04:3.7.a
EXPOSE 8888 8889
COPY supervisord.conf /etc/supervisor/supervisord.conf
CMD ["/usr/bin/supervisord"]
```
We use the docker file to start the supervisord process when the docker start,and copy the `supervisord.conf` file into 
the path `/etc/supervisor/supervisord.conf` of the docker.

## supervisord.conf

lets see the end of the `supervisord.conf` file
```
[supervisord]
nodaemon=true
[program:frp]
command=/root/sxwl-dataset/frp_0.9.3_linux_386/frpc -c /root/sxwl-dataset/frp_0.9.3_linux_386/frpc_min.ini
```

In the `docker-compose.yml` , i mapped the path `~/sxwl-dataset` outside the docker with the path `/root/sxwl-dataset` 
inside the docker ,i have `frp_0.9.3_linux_386/frpc` in the folder `sxwl-dataset`, then i make the command 
`/root/sxwl-dataset/frp_0.9.3_linux_386/frpc -c /root/sxwl-dataset/frp_0.9.3_linux_386/frpc_min.ini` to start the frpc service
when the docker supervisor process start.

