require 'serverspec'

# Required by serverspec
set :backend, :exec

describe 'safari_test::version' do
  case os[:family]
  when 'darwin'
    describe file('/tmp/safari_version.txt') do
      it { should be_file }
      its(:content) { should match(/8.0/) || match(/7.0.6/) }
    end
  end
end
