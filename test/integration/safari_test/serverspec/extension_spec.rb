require 'serverspec'

# Required by serverspec
set :backend, :exec

describe 'safari_test::extension' do
  case os[:family]
  when 'darwin'
    describe file('~/Library/Safari/Extensions/WebDriver.safariextz') do
      it { should be_file }
    end
  end
end
