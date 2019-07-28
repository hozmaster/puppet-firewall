# default pre fw rule 
class bs_firewall::post {

    # drop all by default
    firewall { '999 drop all':
        proto  => 'all',
        action => 'drop',
        before => undef,
    }

}
