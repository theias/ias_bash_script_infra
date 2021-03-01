FROM fedora:31

RUN yum -y update && \
    yum -y install && \
    yum -y install \
        make \
        rpm-build \
        fakeroot

CMD /ias_bash_script_infra/dist/Docker/fedora/31/build-dist.sh
