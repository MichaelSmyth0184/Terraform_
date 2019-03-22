output "linux_box_ips" {
  value = "${module.web.elastic_ips}"
}
output "Windows_box_ips" {
  value = "${module.web-api.elastic_ips}"
}
