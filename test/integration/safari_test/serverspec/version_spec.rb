require 'serverspec'

# Required by serverspec
set :backend, :exec

describe 'safari_test::version' do
  case os[:family]
  when 'darwin'
    describe file('/tmp/safari_version.txt') do
      it { should be_file }
      its(:content) { should match(/\d*\.\d*/) }
    end
  end
end
