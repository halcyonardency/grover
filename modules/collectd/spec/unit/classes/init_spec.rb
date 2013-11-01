# require 'spec_helper'
require "#{File.join(File.dirname(__FILE__),'../../','spec_helper.rb')}"

describe 'collectd' do

  let(:title) { 'collectd' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { {
    :ipaddress => '10.42.42.42',
  } }

  describe 'Test default settings  ' do
    it 'should install collectd package' do should contain_package('collectd').with_ensure('present') end
    it 'should run collectd service' do should contain_service('collectd').with_ensure('running') end
    it 'should enable collectd service at boot' do should contain_service('collectd').with_enable('true') end
    it 'should manage config file presence' do should contain_file('collectd.conf').with_ensure('present') end
  end

  describe 'Test installation of a specific version' do
    let(:params) { {:version => '1.0.42' } }
    it { should contain_package('collectd').with_ensure('1.0.42') }
  end

  describe 'Test decommissioning' do
    let(:params) { {:ensure => 'absent'} }
    it 'should remove Package[collectd]' do should contain_package('collectd').with_ensure('absent') end
    it 'should stop Service[collectd]' do should contain_service('collectd').with_ensure('stopped') end
    it 'should not manage at boot Service[collectd]' do should contain_service('collectd').with_enable(nil) end
    it 'should remove collectd configuration file' do should contain_file('collectd.conf').with_ensure('absent') end
  end

  describe 'Test service disabling' do
    let(:params) { {
      :service_ensure => 'stopped',
      :service_enable => false,
    } }
    it 'should stop Service[collectd]' do should contain_service('collectd').with_ensure('stopped') end
    it 'should not enable at boot Service[collectd]' do should contain_service('collectd').with_enable('false') end
  end

  describe 'Test custom file via template' do
    let(:params) { {
      :file_template => 'collectd/spec/spec.conf.erb',
      :file_options_hash => { 'opt_a' => 'value_a' },
    } }
    it { should contain_file('collectd.conf').with_content(/fqdn: rspec.example42.com/) }
    it 'should generate a template that uses custom options' do
      should contain_file('collectd.conf').with_content(/value_a/)
    end
  end

  describe 'Test custom file via source' do
    let(:params) { {:file_source => "puppet:///modules/collectd/spec/spec.conf"} }
    it { should contain_file('collectd.conf').with_source('puppet:///modules/collectd/spec/spec.conf') }
  end

  describe 'Test customizations - dir' do
    let(:params) { {
      :dir_source => 'puppet:///modules/collectd/tests/',
      :dir_purge => true
    } }
    it { should contain_file('collectd.dir').with_source('puppet:///modules/collectd/tests/') }
    it { should contain_file('collectd.dir').with_purge('true') }
    it { should contain_file('collectd.dir').with_force('true') }
  end

  describe 'Test customizations - custom class' do
    let(:params) { {:my_class => "collectd::spec" } }
    it { should contain_file('my_config').with_content(/my_content/) }
    it { should contain_file('my_config').with_path('/etc/collectd/my_config') }
  end

  describe 'Test file notify default' do
    it 'should automatically restart the service when files change' do
      should contain_file('collectd.conf').with_notify("Service['collectd']")
    end
  end

  describe 'Test file notify to false' do
    let(:params) { {:file_notify => false } }
    it 'should not automatically restart the service when files change' do
      should contain_file('collectd.conf').with_notify(false)
    end
  end

end
