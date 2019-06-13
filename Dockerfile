FROM oraclelinux:7-slim

# set working directory
WORKDIR /app

ARG release=19
ARG update=3

# Install Oracle Instant Client
RUN  yum -y install oracle-release-el7 && yum-config-manager --enable ol7_oracle_instantclient && \
     yum -y install oracle-instantclient${release}.${update}-basic oracle-instantclient${release}.${update}-devel oracle-instantclient${release}.${update}-sqlplus && \
     rm -rf /var/cache/yum

# Install Python 3.6
RUN yum install -y oracle-softwarecollection-release-el7 && \
    yum-config-manager --enable software_collections && \
    yum-config-manager --enable ol7_latest ol7_optional_latest && \
    yum install -y scl-utils rh-python36 && \
    scl enable rh-python36 bash && \
    yum install -y python-pip 

## add instant client to path
ENV PATH=$PATH:/usr/lib/oracle/${release}.${update}/client64/bin
ENV TNS_ADMIN=/usr/lib/oracle/${release}.${update}/client64/lib/network/admin

# for flask web server
EXPOSE 5000

# add wallet files
ADD ./wallet /usr/lib/oracle/${release}.${update}/client64/lib/network/admin/

# add files for python api
ADD ./app.py ./requirements.txt /app/

# Install required libraries
RUN /opt/rh/rh-python36/root/usr/bin/python3.6 -m pip install --upgrade pip
RUN /opt/rh/rh-python36/root/usr/bin/python3.6 -m pip install -r requirements.txt

# This is the runtime command for the container
CMD /opt/rh/rh-python36/root/usr/bin/python3.6 app.py
