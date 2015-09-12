file {
    "/EMPTY": ensure => absent, backup => false;
    "/etc/tgt/targets.conf": ensure => present, source => "/vagrant/conf/targets.conf", 
                             owner => "root", group => "root", mode => "0600",
                             backup => true;
}

package {
    "scsi-target-utils": ensure => installed;
    "parted": ensure => installed;
}

exec {
    "create-partition": command => "create_partition.sh", path => "/vagrant/scripts";
}

service {
    "tgtd": ensure => "running";
}

service {
    "iptables": ensure => "stopped";
}

Package <| |> -> File <| |> -> Exec["create-partition"] -> Service["iptables"] -> Service["tgtd"]
