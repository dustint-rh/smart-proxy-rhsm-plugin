require 'rhsm_plugin/api'

map "/rhsm" do
  run RhsmProxy::Api
end
