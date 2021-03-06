# Encoding: utf-8
require_relative 'spec_helper'

describe 'openstack-network::balancer' do
  describe 'suse' do
    let(:runner) { ChefSpec::Runner.new(SUSE_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) do
      node.set['openstack']['compute']['network']['service_type'] = 'neutron'

      runner.converge(described_recipe)
    end

    include_context 'neutron-stubs'

    ['openstack-neutron-lbaas-agent'].each do |pack|
      it "installs #{pack} package" do
        expect(chef_run).to install_package(pack)
      end
    end

    it 'enables agent service' do
      expect(chef_run).to enable_service('neutron-lb-agent')
    end
  end
end
