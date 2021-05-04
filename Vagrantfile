# -*- mode: ruby -*-
# vim: set ft=ruby :
MACHINES = {
  # VM name "srvbackup"
 :"srvd" => {
              # VM box
              :box_conf => "centos/8",
              # VM CPU count
              :cpus => 1,
              # VM RAM size (Mb)
              :memory => 2048,
              # networks
              :ip_addr => '192.168.10.11',
              # forwarded ports
              #:forwarded_port => [],
              #:sync_path => "./sync_data",
              #:sync_path => ,
              # #:diskv => {
              #           :sata1 => {
              #                       :dfile => './hddvm/sata1.vdi',
              #                       :size => 2048,
              #                       :port => 1
              #                     }
              #           }
                  }
}

Vagrant.configure("2") do |config|

  MACHINES.each do |boxname, boxconfig|
      if Vagrant.has_plugin?("vagrant-timezone")
            config.timezone.value = "Europe/Minsk"
      end
      config.vm.define boxname do |box|
            box.vm.box = boxconfig[:box_conf]
            box.vm.host_name = boxname.to_s
            box.vm.network "private_network", ip: boxconfig[:ip_addr], virtualbox__extnet: "net1"
            box.vm.provider "virtualbox" do |v|
                        # Set VM RAM size, CPU count, add disks
                                v.check_guest_additions=false
                                v.memory = boxconfig[:memory]
                                v.cpus = boxconfig[:cpus]
                                config.vm.synced_folder ".", "/vagrant", disabled: true
                                config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__auto: true, rsync__exclude: ['hddvm/', '.gitignore', '.git']

            end

            box.vm.provision "shell",  inline: <<-SHELL
              dnf install -y --nogpgcheck epel-release > /dev/null 2>&1
              dnf install -y --nogpgcheck lnav mc policycoreutils-python-utils setroubleshoot-server docker buildah podman-compose
              cd /vagrant
              mkdir ./docfile
              touch ./docfile/index.html
              echo "Test server nginx on system alpine 3.12" > ./docfile/index.html
              touch /etc/containers/nodocker
              chcon -R -t container_file_t ./docfile/index.html
              docker build -t dancer76/alpine_nginx:1.0 .
              docker run -d --rm -p 8080:80 --name nginx_alpine dancer76/alpine_nginx:1.0
              # dnf install -y --nogpgcheck borgbackup sshpass > /dev/null 2>&1
                  SHELL



      end

  end
end
