FROM docker:17.09.0
COPY root /opt/docker/
RUN ["sh", "/opt/docker/run.sh"]
USER user
SHELL BASH
ENTRYPOINT ["sh", "/opt/docker/entrypoint.sh"]
CMD []