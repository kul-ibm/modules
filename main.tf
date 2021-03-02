provider "aws" {
  region = "us-east-2"
}

module "createServer" {
  source = "./modules/procureServer"
}

module "installAnsible" {
  for_each = toset(module.createServer.public_ip)
  source = "./modules/installAnsible"
  host = each.value
  pemFile = "c:/training/kul-labs.pem"
}

output "public-ips" {
  value = module.createServer.public_ip
}