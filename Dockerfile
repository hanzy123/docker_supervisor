FROM sx/ubuntu14.04:3.7.a
EXPOSE 8888 8889
COPY supervisord.conf /etc/supervisor/supervisord.conf
CMD ["/usr/bin/supervisord"]
