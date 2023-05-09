docker service create --name cadvisor -l prometheus-job=cadvisor \
    --mode=global --publish published=8080,target=8080,mode=host \
    --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock,ro \
    --mount type=bind,src=/,dst=/rootfs,ro \
    --mount type=bind,src=/var/run,dst=/var/run \
    --mount type=bind,src=/sys,dst=/sys,ro \
    --mount type=bind,src=/var/lib/docker,dst=/var/lib/docker,ro \
    gcr.io/cadvisor/cadvisor:v0.47.0 -docker_only