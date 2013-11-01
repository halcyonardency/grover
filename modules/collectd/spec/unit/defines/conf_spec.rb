require "#{File.join(File.dirname(__FILE__),'../../','spec_helper.rb')}"

describe 'stdmod::conf' do

  let(:title) { 'stdmod::conf' }
  let(:node) { 'rspec.example42.com' }
  let(:params) {
    { 'name'     =>  'sample1',
      'options'  => { 'opt_a' => 'value_a' , 'opt_b' => 'value_b' },
    }
  }

  describe 'Test stdmod conf file creation by default' do
    it 'should create a sample1 file' do
      should contain_file('stdmod_conf_sample1').with_ensure('present')
      should contain_file('stdmod_conf_sample1').with_path('/etc/stdmod/sample1')
    end
    it 'should populate correctly sample1 file' do
      content = catalogue.resource('file', 'stdmod_conf_sample1').send(:parameters)[:content]
      content.should match(/value_a/)
    end
  end

  describe 'Test stdmod conf custom template' do
    let(:params) {
      { 'name'     =>  'sample2',
        'template' =>  'stdmod/tests/test.erb',
        'options'  => { 'opt_a' => 'value_a' , 'opt_b' => 'value_b' },
      }
    }

    it 'should create a sample2 file' do
      should contain_file('stdmod_conf_sample2').with_ensure('present')
      should contain_file('stdmod_conf_sample2').with_path('/etc/stdmod/sample2')
    end
    it 'should contain custom content' do
      content = catalogue.resource('file', 'stdmod_conf_sample2').send(:parameters)[:content]
      content.should match (/This is a template used only for tests/)
    end
  end

  describe 'Test stdmod conf file deletion' do
    let(:params) {
      { 'name'    =>  'sample3',
        'ensure'  =>  'absent',
      }
    }

    it 'should not create a sample3 file' do
      should contain_file('stdmod_conf_sample3').with_ensure('absent')
    end
  end

end

