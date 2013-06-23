# Remove veewee files
file {
    "/EMPTY": ensure => absent, backup => false;
}

package {
    "scsi-target-utils": ensure => installed;
    "parted": ensure => installed;
}

exec {
    "create-partition":
        command => "create_partition.sh",
        path => "/vagrant";
}

File["/EMPTY"] -> Package <| |> -> Exec["create-partition"] 
