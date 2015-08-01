require 'serverspec'

# Required by serverspec
set :backend, :exec

describe 'safari_test::extension' do
  case os[:family]
  when 'darwin'
    # This will fail on every other convergence because the name will toggle
    # back and forth between WebDriver.safariextz and WebDriver2.safariextz
    describe file('/Users/vagrant/Library/Safari/Extensions/WebDriver.safariextz') do
      it { should be_file }
    end
  end
end
