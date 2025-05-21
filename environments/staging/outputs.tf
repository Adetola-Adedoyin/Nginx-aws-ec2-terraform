output "network_id" {
  value = module.network.vpc_id
}

output "instance_id" {
  value = module.compute.instance_id
}

output "bucket_name" {
  value = module.data.bucket_name
}