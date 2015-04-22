require 'spec_helper'

describe 'safari_test::extension' do
  context 'mac' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        file_cache_path: '.chef/chefspec/cache',
        platform: 'mac_os_x',
        version: '10.10',
        step_into: ['safari_extensions']
      ).converge(described_recipe)
    end

    it 'downloads extension' do
      expect(chef_run).to create_remote_file('.chef/chefspec/cache/SafariDriver.safariextz')
    end

    it 'installs extension' do
      expect(chef_run).to install_safari_extension('.chef/chefspec/cache/SafariDriver.safariextz')
    end
  end

  context 'non-mac' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(file_cache_path: '.chef/chefspec/cache',
                               platform: 'ubuntu',
                               version: '14.04',
                               step_into: ['safari_extension']).converge(described_recipe)
    end

    it 'downloads extension' do
      expect(chef_run).to create_remote_file('.chef/chefspec/cache/SafariDriver.safariextz')
    end

    it 'installs extension' do
      expect(chef_run).to install_safari_extension('.chef/chefspec/cache/SafariDriver.safariextz')
    end

    it 'logs safari_extension is not supported' do
      expect(chef_run).to write_log('Resource safari_extension is not supported on this platform.')
    end
  end
end
