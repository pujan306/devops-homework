provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "hello-world-app" {
  name       = "hello-world-app"
  repository = "../../helm"
  chart      = "hello-world-app"

  values = [
    file("${path.module}/values.yaml")
  ]
}