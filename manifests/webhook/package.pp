# Private class, do not include it directly.
# Installs the webhook packages
class r10k::webhook::package (
  $is_pe_server = $r10k::params::is_pe_server,
  $provider     = $r10k::params::provider,
) inherits r10k::params {

  if $is_pe_server {
    if !defined(Package['sinatra']) {
      package { 'sinatra':
        ensure   => installed,
        provider => $provider,
        before   => Service['webhook'],
      }
    }
  } else {
    if !defined(Package['webrick']) {
      package { 'webrick':
        ensure   => installed,
        provider => $provider,
        before   => Service['webhook'],
      }
    }

    if !defined(Package['json']) {
      package { 'json':
        ensure   => installed,
        provider => $provider,
        before   => Service['webhook'],
      }
    }

    if !defined(Package['sinatra']) {
      package { 'sinatra':
        ensure   => installed,
        provider => $provider,
        before   => [
          Service['webhook'],
          File['webhook_init_script'],
        ],
      }
    }
  }
}
