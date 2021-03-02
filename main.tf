provider "aws" {
  region = "us-east-2"
}

module "createServer" {
  source = "./modules/procureServer"
}

module "installAnsible" {
  depends_on = [ module.createServer ]
  for_each = toset(module.createServer.public_ip)
  source = "./modules/installAnsible"
  host = each.value
  pemFile = "c:/training/kul-labs.pem"
}

module "createManagedServer" {
  source = "./modules/procureServer"
  quantity = 2
}

output "public-ips" {
  value = module.createServer.public_ip
}