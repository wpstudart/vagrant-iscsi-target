# -*- mode: ruby -*-
# vi: set ft=ruby :

vb_iscsi_disk = "iscsi_storage_disk"
vb_disk_path = ENV['HOME'] + "/VirtualBox VMs/virtualbox_disks/" + vb_iscsi_disk + ".vmdk"
vb_iscsi_disk_uuid = "804561f0-db55-11e2-a28f-0800200c9a66"

Vagrant.configure("2") do |config|
  config.vm.box = "centos6_x86_64"
  config.vm.box_url = "http://rafacas.net/vagrant_boxes/centos6_x86_64.box"
  config.vm.hostname = "iscsi-storage"
  config.vm.network :private_network, ip: "192.168.56.10"
  config.vm.network :public_network

  config.vm.provider "virtualbox" do |vb|
    # Create and attach a new hard disk (10GB)
    vb.customize ["createhd", "--filename", vb_disk_path, "--size", "10240", "--format", "VMDK"]
    vb.customize ["storageattach", :id, "--storagectl", "SATA Controller", "--port", "1", "--medium", 
                   vb_disk_path, "--type", "hdd", "--setuuid", vb_iscsi_disk_uuid]
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet_manifests"
    puppet.manifest_file  = "init.pp"
  end

end
