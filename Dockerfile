##
#build simplex dbt image for snowflake
##

##
# base image (abstract)
##
FROM python:3.8-bullseye

# System setup
RUN apt-get update \
  && apt-get dist-upgrade -y \
  && apt-get install -y --no-install-recommends \
    git \
    ssh-client \
    software-properties-common \
    make \
    build-essential \
    ca-certificates \
    libpq-dev \
  && apt-get clean \
  && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

# Env vars
ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8

# Update python
RUN python -m pip install --upgrade pip setuptools wheel --no-cache-dir

#Install AWS CLI
RUN python -m pip install awscli

# Set working directory
WORKDIR /dbt_ods

# Create directory for dbt config
RUN mkdir -p /root/.dbt

# Copy requirements.txt
COPY ./requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt

# Update OpenSSL
RUN apt-get update && apt-get install -y openssl

# Copy dbt profile
COPY profiles.yml /root/.dbt/profiles.yml

# Copy source code
COPY ./dbt_ods /dbt_ods

WORKDIR /dbt_ods

# Start the dbt RPC server
ADD start_rpc.sh /
RUN chmod +x /start_rpc.sh
EXPOSE 8580
ENTRYPOINT [ "/start_rpc.sh" ]
CMD ["dbt-rpc" ,"serve"]
