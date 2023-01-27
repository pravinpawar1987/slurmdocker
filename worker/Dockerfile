FROM almalinux:8
MAINTAINER pravin pawar

# install openmpi 3.0.1
COPY rpms /packages
RUN dnf --enablerepo=powertools -y install \
   epel-release \
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
  && dnf --enablerepo=powertools -y install \
   tini \
   tini-static \
  && dnf --enablerepo=powertools -y localinstall \
  /packages/*.rpm 

# install Lmod 7.7
RUN dnf --enablerepo=powertools -y install \
  lua-posix \
  lua \
  perl-Switch \
  lua-filesystem \
  lua-devel \
  wget \
  bzip2 \
  expect \
  make 
#  && wget https://sourceforge.net/projects/lmod/files/Lmod-7.7.tar.bz2 \
#  && tar -xjvf Lmod-7.7.tar.bz2
#WORKDIR /Lmod-7.7
#RUN ./configure --prefix=/opt/apps \
#  && make install \
#  && ln -s /opt/apps/lmod/lmod/init/profile /etc/profile.d/z00_lmod.sh \
#  && ln -s /opt/apps/lmod/lmod/init/cshrc /etc/profile.d/z00_lmod.csh

ENV WORKER_UID=1000 \
    SLURM_UID=992

RUN groupadd -g $WORKER_UID worker \
  && useradd  -m -c "Workflow user" -d /home/worker -u $WORKER_UID -g worker  -s /bin/bash worker \
  && groupadd -g $SLURM_UID slurm \
  && useradd  -m -c "Slurm workload manager" -d /var/lib/slurm -u $SLURM_UID -g slurm  -s /bin/bash slurm

COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /home/worker


# clean up
RUN rm -f /packages/slurm-*.rpm /packages/openmpi-*.rpm \
  && yum clean all \
  && rm -rf /var/cache/yum 
#  && rm -f /Lmod-7.7.tar.bz2

ENTRYPOINT ["/usr/bin/tini", "--", "/docker-entrypoint.sh"]
