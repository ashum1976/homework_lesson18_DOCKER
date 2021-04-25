# -*- mode: ruby -*-
# vim: set ft=ruby :
MACHINES = {
  # VM name "srvbackup"
 :"srvrsl" => {
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
                  },
  :"clientrsl" => {
              # VM box
              :box_conf => "centos/8",
              # VM CPU count
              :cpus => 1,
              # VM RAM size (Mb)
              :memory => 512,
              # networks
              :ip_addr => '192.168.10.10'
            }
}

Vagrant.configure("2") do |config|

  MACHINES.each do |boxname, boxconfig|
      #if Vagrant.has_plugin?("vagrant-timezone")
      #      config.timezone.value = "Europe/Minsk"
      #end
      config.vm.define boxname do |box|
            box.vm.box = boxconfig[:box_conf]
            box.vm.host_name = boxname.to_s
            box.vm.network "private_network", ip: boxconfig[:ip_addr], virtualbox__intnet: "net1"
            box.vm.provider "virtualbox" do |v|
                        # Set VM RAM size, CPU count, add disks
                                v.check_guest_additions=false
                                v.memory = boxconfig[:memory]
                                v.cpus = boxconfig[:cpus]
                                config.vm.synced_folder ".", "/vagrant", disabled: true
                                config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__auto: true, rsync__exclude: ['hddvm/', '.gitignore', '.git']
                                # if boxconfig.key?(:diskv)
                                # needsController = false
                                #         boxconfig[:diskv].each do |dname, dconf|
                                #               unless File.exist?(dconf[:dfile])
                                #               v.customize ['createhd', '--filename', dconf[:dfile], '--variant', 'Fixed', '--size', dconf[:size]]
                                #               needsController = true
                                #             end
                                #           end
                                #       if needsController == true
                                #                v.customize ["storagectl", :id, "--name", "SATA", "--add", "sata" ]
                                #                boxconfig[:diskv].each do |dname, dconf|
                                #                v.customize ['storageattach', :id,  '--storagectl', 'SATA', '--port', dconf[:port], '--device', 0, '--type', 'hdd', '--medium', dconf[:dfile]]
                                #            end
                                #       end
                                # end
            end

            box.vm.provision "shell",  inline: <<-SHELL
              dnf install -y --nogpgcheck epel-release > /dev/null 2>&1
              dnf install -y --nogpgcheck lnav mc policycoreutils-python-utils setroubleshoot-server docker
              # dnf install -y --nogpgcheck borgbackup sshpass > /dev/null 2>&1
                  SHELL
            #  if boxname.to_s == "srvrsl"
            #    box.vm.provision "shell",  inline: <<-SHELL
            #    cp /vagrant/rsyslog_conf/{99-gconf.conf,remote_log.conf} /etc/rsyslog.d/
            #    systemctl restart rsyslog
            #    SHELL
            # #   box.vm.provision "shell", path: "srvrsl.sh"
            #
            #  end
            #  if boxname.to_s == "clientrsl"
            #   box.vm.provision "shell",  inline: <<-SHELL
            #   dnf install -y --nogpgcheck nginx > /dev/null 2>&1
            #   systemctl enable --now nginx
            #   SHELL
            #   box.vm.provision "shell", path: "clientrsl.sh"

             # end


      end

  end
end
