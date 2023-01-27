FROM almalinux:8
MAINTAINER Pravin Pawar

ENV SLURM_VERSION=22.05.7
 
RUN dnf --enablerepo=powertools -y install \
  drpm \
  epel-release \
  && dnf --enablerepo=powertools -y install \
  which \
  wget \
  munge \
  munge-libs \
  munge-devel \
  rpm-build \
  gcc \
  openssl \
  openssl-devel \
  libssh2-devel \
  pam-devel \
  numactl \
  numactl-devel \
  hwloc \
  hwloc-devel \
  lua \
  lua-devel \
  readline-devel \
  rrdtool-devel \
  ncurses-devel \
  gtk2-devel \
  man2html \
  libibmad \
  libibumad \
  perl-Switch \
  perl-ExtUtils-MakeMaker \
  mariadb-server \
  mariadb-devel \
  python3 \
  && dnf -y group install "Development Tools"

COPY docker-entrypoint.sh /docker-entrypoint.sh
VOLUME ["/packages"]
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["ls", "-alh", "/packages"]
