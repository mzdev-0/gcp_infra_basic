output "traefik_load_balancer_ip" {
    value = helm_release.traefik.status[0].load_balancer[0].ingress[0].ip
    description = "The external IP address of the Traefik load balancer"
}
