# Remove veewee files
file {
    "/EMPTY": ensure => absent, backup => false;
}

package {
    "scsi-target-utils": ensure => installed;
}
