output "vm_azure_ip" {
  value = azurerm_linux_virtual_machine.vm.public_ip_addresses
}

output "vm_aws_ip" {
  value = aws_instance.vm.public_ip
}

output "vm_dns" {
  value = aws_instance.vm.public_dns
}