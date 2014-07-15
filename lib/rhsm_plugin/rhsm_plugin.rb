module RhsmProxy
  class Plugin < ::Proxy::Plugin
    plugin "rhsm", ::RhsmProxy::VERSION
    default_settings :rhsm_url => 'https://localhost:8443/rhsm'

    http_rackup_path File.expand_path("http_config.ru", File.expand_path("../", __FILE__))
    https_rackup_path File.expand_path("http_config.ru", File.expand_path("../", __FILE__))
  end
end
