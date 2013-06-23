# Remove veewee files
file {
    "/EMPTY": ensure => absent, backup => false;
    "/etc/tgt/targets.conf": ensure => present, source => "/vagrant/targets.conf", 
                             owner => "root", group => "root", mode => "0600",
                             backup => true;
}

package {
    "scsi-target-utils": ensure => installed;
    "parted": ensure => installed;
}

exec {
    "create-partition": command => "create_partition.sh", path => "/vagrant";
}

service {
    "tgtd": ensure => "running";
}

File<| |> -> Package <| |> -> Exec["create-partition"] -> Service["tgtd"]
