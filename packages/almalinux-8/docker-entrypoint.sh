#!/usr/bin/env bash
set -e

# build slurm rpms
wget https://download.schedmd.com/slurm/slurm-${SLURM_VERSION}.tar.bz2
rpmbuild -ta "slurm-${SLURM_VERSION}.tar.bz2"
cp /root/rpmbuild/RPMS/x86_64/slurm-* /packages

# build openmpi rpm
dnf --enablerepo=powertools -y install  epel-release
dnf --enablerepo=powertools -y install gcc-gfortran gcc-c++ hwloc-gui java-devel libevent-devel libfabric-devel libpsm2-devel opensm-devel papi-devel pmix-devel python3-devel rpm-mpi-hooks torque-devel ucx-devel

rpmbuild --rebuild http://vault.centos.org/8-stream/AppStream/Source/SPackages/openmpi-4.0.5-3.el8.src.rpm

cp /root/rpmbuild/RPMS/x86_64/openmpi* /packages

dnf -y localinstall packages/openmpi*.rpm


cp /root/rpmbuild/RPMS/x86_64/openmpi* /packages

#curl https://raw.githubusercontent.com/open-mpi/ompi/v3.0.x/contrib/dist/linux/buildrpm.sh -o buildrpm.sh
#chmod +x buildrpm.sh
cd 
yum -y localinstall /root/rpmbuild/RPMS/x86_64/slurm-* /root/rpmbuild/RPMS/x86_64/openmpi*
mkdir -p /usr/src/redhat
cd /usr/src/redhat
ln -s /root/rpmbuild/SOURCES SOURCES
ln -s /root/rpmbuild/RPMS RPMS
ln -s /root/rpmbuild/SRPMS SRPMS
ln -s /root/rpmbuild/SPECS SPECS
cd -
cp /root/rpmbuild/RPMS/x86_64/openmpi* /packages

exec "$@"
