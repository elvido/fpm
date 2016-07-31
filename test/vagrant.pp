case $operatingsystem {
  centos, redhat, fedora: {
    $pkgupdate = "yum clean all"
<<<<<<< HEAD
    $devsuffix = "devel"
  }
  debian, ubuntu: {
    $pkgupdate = "apt-get update"
    $devsuffix = "dev"
=======
    $devsuffix = "-devel"
  }
  debian, ubuntu: {
    $pkgupdate = "apt-get update"
    $devsuffix = "-dev"
>>>>>>> 40ec0c3576e02e7b8402df13185c8240adbd0e86
    package {
      "lintian": ensure => latest
    }
  }
<<<<<<< HEAD
=======
  Archlinux: {
    $pkgupdate = "pacman -Syu --noconfirm --needed"
    $devsuffix = "dev"
  }
>>>>>>> 40ec0c3576e02e7b8402df13185c8240adbd0e86
}

exec {
  "update-packages":
    command => $pkgupdate,
<<<<<<< HEAD
    path => [ "/bin", "/usr/bin", "/sbin", "/usr/sbin" ];
=======
    path => [ "/bin", "/usr/bin", "/sbin", "/usr/sbin" ],
    timeout => 14400
>>>>>>> 40ec0c3576e02e7b8402df13185c8240adbd0e86
}

package {
  "git": ensure => latest;
  "bundler": provider => "gem", ensure => latest;
<<<<<<< HEAD
  "ruby-$devsuffix": ensure => latest;
=======
  "ruby$devsuffix": ensure => latest;
>>>>>>> 40ec0c3576e02e7b8402df13185c8240adbd0e86
}

Exec["update-packages"] -> Package <| |>
