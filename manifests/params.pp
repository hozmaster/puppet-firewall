# ntp/functions/params.pp
function foobar::params(
    Hash                  $options, # We ignore both of these arguments, but
    Puppet::LookupContext $context, # the function still needs to accept them.
) {
    $base_params = {
        'foobar::autoupdate'   => false,
        # Keys have to start with the module's namespace, which in this case is `ntp::`.
        'foobar::service_name' => 'ntpd',
        # Use key names that work with automatic class parameter lookup. This
        # key corresponds to the `ntp` class's `$service_name` parameter.
    }

    $os_params = case $facts['os']['family'] {
        'AIX': {
            { 'ntp::service_name' => 'xntpd' }
        }
        'Debian': {
            { 'ntp::service_name' => 'ntp' }
        }
        default: {
            {}
        }
    }

    # Merge the hashes, overriding the service name if this platform uses a non-standard one:
    $base_params + $os_params
}
