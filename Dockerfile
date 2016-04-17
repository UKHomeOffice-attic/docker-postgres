FROM quay.io/ukhomeofficedigital/centos-base

# explicitly set user/group IDs
RUN groupadd -r postgres --gid=1001 && useradd -r -g postgres --uid=1001 postgres
RUN mkdir /home/postgres

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.7
RUN yum install -y wget
RUN set -x \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true \
    && yum remove -y wget

# Setup repository to install postgresql from
RUN echo "exclude=postgresql*" >> /etc/yum.repos.d/CentOS-Base.repo
RUN yum localinstall https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-2.noarch.rpm -y
RUN yum install postgresql95-server.x86_64 -y

RUN mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql

ENV PGDATA /var/lib/postgresql/data
ENV PATH /usr/pgsql-9.5/bin:$PATH

COPY postgresql.conf /conf/postgresql.conf
COPY docker-entrypoint.sh /
COPY healthcheck.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
