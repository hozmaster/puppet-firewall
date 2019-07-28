# default pre fw rule 
class yed_fw::post {

  # drop all by default
  firewall { '999 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }

}
