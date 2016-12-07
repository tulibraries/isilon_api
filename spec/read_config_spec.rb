require 'spec_helper'
require 'isilon_api'

describe IsilonApi::Base do
  let(:config_options) {
    { 'user'     => 'MyUsername',
      'password' => 'MyPasswd',
      'host'     => 'hostname',
      'port'     => '8080' }
  }

  before do
    IsilonApi.configure do |config|
      config.user     = config_options['user']
      config.password = config_options['password']
      config.host     = config_options['host']
      config.port     = config_options['port']
    end
  end

  describe '#base_uri' do
    it 'creates the expected base url' do
      @base = IsilonApi::Base.new
      expect(@base.base_uri).to eql "https://#{config_options['host']}:#{config_options['port']}"
    end
  end
end
