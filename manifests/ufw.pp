class foobar::ufw  {
    include ufw

    ufw::allow { "allow-ssh-from-all":
        port => 22,
    }

    define allow_shortcut (
        String $shortcut ) {

        $command = $shortcut ? {
            default => "ufw allow '${shortcut}'",
        }

        $unless  = "${shortcut}" ? {
            default      => "ufw status | grep -qE '^${shortcut} +ALLOW '",
        }

        exec { "ufw-allow-${shortcut}":
            command  => $command,
            path     => '/usr/sbin:/bin:/usr/bin',
            provider => 'posix',
            unless   => $unless,
            require  => Exec['ufw-default-deny'],
            before   => Exec['ufw-enable'],
        }
    }

    define deny_shortcut (
        String $shortcut ) {

        $command = $shortcut ? {
            default => "ufw deny '${shortcut}'",
        }

        $unless  = "${shortcut}" ? {
            default      => "ufw status | grep -qE '^${shortcut} +DENY '",
        }

        exec { "ufw-deny-${shortcut}":
            command  => $command,
            path     => '/usr/sbin:/bin:/usr/bin',
            provider => 'posix',
            unless   => $unless,
            require  => Exec['ufw-default-deny'],
            before   => Exec['ufw-enable'],
        }
    }

    # profile::ufw::allow_shortcut { "ufw_allow_bind9" :
    #     shortcut => 'Bind9',
    # }

    profile::ufw::deny_shortcut { "ufw_deny_bind9" :
        shortcut => 'Bind9',
    }

    profile::ufw::allow_shortcut { "ufw_allow_apache_full" :
        shortcut => 'Apache Full',
    }

}
