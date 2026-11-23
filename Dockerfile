FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    libpq-dev \
    libsasl2-dev \
    libldap2-dev \
    libssl-dev \
    ca-certificates \
    curl \
    build-essential \
    git \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /odoo

COPY requirements.txt /odoo/requirements.txt
RUN pip install -r requirements.txt

COPY . /odoo

EXPOSE 8069

COPY docker-entrypoint.sh /odoo/docker-entrypoint.sh
RUN chmod +x /odoo/docker-entrypoint.sh

ENTRYPOINT ["/odoo/docker-entrypoint.sh"]