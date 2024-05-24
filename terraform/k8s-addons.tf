# # Add and configure MetalLB for Load Balancing
# resource "helm_release" "metallb" {
#   name             = "metallb"
#   repository       = "https://metallb.github.io/metallb"
#   chart            = "metallb"
#   namespace        = "metallb-system"
#   create_namespace = true
#   cleanup_on_fail  = true

#   # MetalLB does not typically require additional set parameters for basic setup
#   # This will install MetalLB with default settings, suitable for many environments
# }

# # Apply MetalLB configuration for IP range handling
# resource "kubectl_manifest" "metallb_config" {
#   yaml_body = <<-EOF
#   apiVersion: metallb.io/v1beta1
#   kind: IPAddressPool
#   metadata:
#     name: default-pool
#     namespace: metallb-system
#   spec:
#     addresses:
#     - 10.0.0.70-10.0.0.80
#   ---
#   apiVersion: metallb.io/v1beta1
#   kind: L2Advertisement
#   metadata:
#     name: default
#     namespace: metallb-system
#   spec:
#     ipAddressPools:
#     - default-pool
#   EOF
# }

# # Deploy Longhorn for distributed storage
# resource "helm_release" "longhorn" {
#   name             = "longhorn"
#   repository       = "https://charts.longhorn.io"
#   chart            = "longhorn"
#   namespace        = "longhorn-system"
#   create_namespace = true
#   cleanup_on_fail  = true

#   set {
#     name  = "defaultSettings.defaultDataPath"
#     value = "/storage"
#   }
# }

# # Deploy Traefik as the Ingress Controller
# resource "helm_release" "traefik" {
#   name             = "traefik"
#   repository       = "https://helm.traefik.io/traefik"
#   chart            = "traefik"
#   namespace        = "traefik"
#   create_namespace = true
#   cleanup_on_fail  = true

#   set {
#     name  = "additionalArguments"
#     value = "{--providers.kubernetesingress.ingressclass=traefik,--entryPoints.websecure.http.tls=true}"
#   }
# }

# # Deploy Argo CD for continuous deployment
# resource "helm_release" "argocd" {
#   name             = "argocd"
#   repository       = "https://argoproj.github.io/argo-helm"
#   chart            = "argo-cd"
#   namespace        = "argocd"
#   create_namespace = true
#   cleanup_on_fail  = true

#   set {
#     name  = "server.service.type"
#     value = "ClusterIP"
#   }
# }

# # Outputs to verify the status of deployed Helm releases
# output "metallb_status" {
#   value     = helm_release.metallb.status
#   sensitive = false
# }

# output "longhorn_status" {
#   value     = helm_release.longhorn.status
#   sensitive = false
# }

# output "traefik_status" {
#   value     = helm_release.traefik.status
#   sensitive = false
# }

# output "argocd_status" {
#   value     = helm_release.argocd.status
#   sensitive = false
# }
