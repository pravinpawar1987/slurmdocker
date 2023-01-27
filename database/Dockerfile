FROM cdac/slurm.base:22.05.7
MAINTAINER Pravin Pawar

RUN dnf --enablerepo=powertools -y install \
   epel-release \
   && dnf --enablerepo=powertools -y install \
   sudo \
   tini \
   tini-static \
   vim \
   procps-ng 

ENV DBD_ADDR=database \
  DBD_HOST=database \
  DBD_PORT=6819 \
  STORAGE_HOST=database.local.dev \
  STORAGE_PORT=3306 \
  STORAGE_PASS=password \
  STORAGE_USER=slurm

# clean up
RUN rm -f /packages/slurm-*.rpm /packages/openmpi-*.rpm \
  && yum clean all \
  && rm -rf /var/cache/yum

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/usr/bin/tini", "--", "/docker-entrypoint.sh"]
