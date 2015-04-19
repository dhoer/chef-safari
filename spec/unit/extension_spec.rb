require 'spec_helper'

describe 'safari_test::extension' do
  context 'mac' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'mac_os_x',
        version: '10.7.4',
        step_into: ['safari']
      ).converge(described_recipe)
    end

    # TODO: add tests
  end

  context 'non-mac' do
    let(:chef_run) { ChefSpec::SoloRunner.new(step_into: ['safari']).converge(described_recipe) }

    # TODO: add tests
  end
end
