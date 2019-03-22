# output "linux_box_ips" {
#   value = "${module.linux_server.elastic_ips}"
# }
output "Windows_box_ips" {
  value = "${module.windows_server.elastic_ips}"
}