module "rg_create" {
  source = "../1-resource-grp"
}

module "vnet-create" {
  depends_on = [module.rg_create]
  source     = "../4-vnet"
}

module "subnet-create" {
  depends_on = [module.vnet-create]
  source     = "../5-subnet"
}

module "pip-create" {
  depends_on = [module.subnet-create]
  source     = "../6-publicip"
}

module "net-int" {
  depends_on = [module.pip-create]
  source     = "../7-net-interface"
}
module "sql_server_create" {
  depends_on = [module.net-int]
  source     = "../2-sql-server-module"
}

module "db_create" {

  depends_on = [module.sql_server_create]
  source     = "../3-sql-database"
}

module "vm-1" {
  depends_on = [module.db_create]
  source     = "../8-vm-backend"
}

module "vm-2" {
  depends_on = [module.vm-1]
  source     = "../9-vm-frontend"
}

module "nsg-link_nsg" {
  depends_on = [ module.vm-2]
  source = "../10-nsg"
}

output "backend_ip_address" {
  value = module.pip-create.backend_ip_address
}
 output "frontend_ip_address" {
   value = module.pip-create.frontend_ip_address
 }