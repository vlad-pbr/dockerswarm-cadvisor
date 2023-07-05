Docker Swarm CAdvisor Monitoring
================================

Compose file for monitoring performance of all containers using CAdvisor, Prometheus and Grafana.

# Overview

The stack is very basic:
- CAdvisor is deployed on each node in `global` service deployment mode
- Prometheus automatically discovers CAdvisor instances and scrapes them
- Grafana queries Prometheus for existing metrics so dashboards could be built and displayed

# Configuration

Stack deployment can be configured via a `.env` file which comes with this repository. The following variables are used in the stack:

- `CADVISOR_IMAGE`: image for CAdvisor instances
- `PROMETHEUS_IMAGE`: image for the Prometheus instance
- `GRAFANA_IMAGE`: image for the Grafana instance

This stack is preconfigured for one specific task, but can be freely edited and extended to your liking. For example, this stack will use the `prometheus.yml` file which comes with this repository in order to configure Prometheus behavior. You can easily extend this configuration to include your own exporters.

# Deployment

First, make sure you complete all of the prep work:

## Prerequisites

- Docker Swarm up and running
- `.env` file configured for your environment
- Front facing created as secrets in PEM format called `cert.pem` and `key.pem` (you can edit the stack to not use certificates, but, in my opinion, it's crucial)
- all of the relevant docker images accessible from the Swarm

## Procedure

1. Log-in to a Swarm manager and transfer the `docker-compose.yaml`, `prometheus.yml` as well as the edited `.env` file to it.

2. Substitute the environment variables and deploy the stack like so:
   ```sh
   # register environment variables
   set -a
   . .env
   set +a

   # substitute variables and deploy the stack
   envsubst < docker-compose.yml | docker stack deploy monitoring -c -