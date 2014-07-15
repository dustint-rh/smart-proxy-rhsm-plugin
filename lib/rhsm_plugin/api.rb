require 'sinatra'
require 'rhsm_plugin/client'

module RhsmProxy
  class Api < Sinatra::Base
    helpers ::Proxy::Helpers

    get "/status" do
      content_type :json
      begin
        result = RhsmClient.get("/")
        return result.body if result.is_a?(Net::HTTPSuccess)
        log_halt result.code, "Katello rhsm at #{::RhsmProxy::Plugin.settings.rhsm_url} returned an error: '#{result.message}'"
      rescue Errno::ECONNREFUSED => e
        log_halt 503, "Katello rhsm at #{::RhsmProxy::Plugin.settings.pulp_url} is not responding"
      rescue SocketError => e
        log_halt 503, "Katello rhsm '#{URI.parse(::RhsmProxy::Plugin.settings.pulp_url.to_s).host}' is unknown"
      end
    end
  end
end
