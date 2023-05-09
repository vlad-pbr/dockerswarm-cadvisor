docker service create --replicas 1 --name prometheus \
    --mount type=bind,source=/home/vlad/work/swarm-prometheus/prometheus.yml,destination=/etc/prometheus/prometheus.yml,ro \
    --mount type=bind,source=/var/run/docker.sock,destination=/var/run/docker.sock,ro \
    --publish published=9090,target=9090,protocol=tcp \
    prom/prometheus