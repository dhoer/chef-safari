require 'spec_helper'

describe 'safari_test::version' do
  context 'mac' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'mac_os_x', version: '10.7.4').converge(described_recipe) }
    let(:shellout) { double(run_command: nil, error!: nil, stdout: '8.0.4') }

    before { allow(Mixlib::ShellOut).to receive(:new).and_return(shellout) }

    it 'returns safari version' do
      expect(chef_run).to write_log('8.0.4')
    end
  end

  context 'non mac' do
    let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

    it 'returns safari version as nil' do
      expect(chef_run).to write_log('Safari version is not available on this platform.')
    end
  end
end
