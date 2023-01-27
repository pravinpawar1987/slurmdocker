FROM almalinux:8
MAINTAINER pravin pawar

# install openmpi 4.1.0
COPY rpms /packages
RUN dnf --enablerepo=powertools -y install \
   epel-release \
  && dnf --enablerepo=powertools -y install \
  gcc-gfortran \
  gcc-c++ \
  hwloc-gui \
  java-devel \
  libevent-devel \
  libfabric-devel \
  libpsm2-devel \
  opensm-devel \
  papi-devel \
  pmix-devel \
  python3-devel \
  rpm-mpi-hooks \
  torque-devel \
  ucx-devel \
  openssh-server \
  sudo \
  tini \
  tini-static \
  && dnf --enablerepo=powertools -y localinstall \
  /packages/*.rpm 

# install Lmod 8.5
RUN dnf --enablerepo=powertools -y install \
  lua-posix \
  lua \
  lua-filesystem \
  lua-devel \
  wget \
  bzip2 \
  expect \
  make \
  perl-Switch 

ENV USE_SLURMDBD=true \
  CLUSTER_NAME=param \
  CONTROL_MACHINE=controller \
  SLURMCTLD_PORT=6817 \
  SLURMD_PORT=6818 \
  ACCOUNTING_STORAGE_HOST=database \
  ACCOUNTING_STORAGE_PORT=6819 \
  PARTITION_NAME=docker

# clean up
RUN rm -ri /packages/slurm-*.rpm /packages/openmpi-*.rpm \
  && yum clean all \
  && rm -rf /var/cache/yum \
  && rm -f /Lmod-7.7.tar.bz2

ENV WORKER_UID=1000 \
    SLURM_UID=992

RUN groupadd -g $WORKER_UID worker \
  && useradd  -m -c "Workflow user" -d /home/worker -u $WORKER_UID -g worker  -s /bin/bash worker \
  && groupadd -g $SLURM_UID slurm \
  && useradd  -m -c "Slurm workload manager" -d /var/lib/slurm -u $SLURM_UID -g slurm  -s /bin/bash slurm


COPY docker-entrypoint.sh /docker-entrypoint.sh
#COPY slurm.conf.example /etc/slurm/slurm.conf

ENTRYPOINT ["/usr/bin/tini", "--", "/docker-entrypoint.sh"]
