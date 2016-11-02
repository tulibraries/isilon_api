require 'spec_helper'

RSpec.configure do |config|
  config.before(:each) do
    @config = IsilonApi.configuration
    stub_request(:get, "https://isilon.example.com:8080/platform/1/quota/quotas").with(basic_auth: [@config.user, @config.password]).
        to_return(:status => 200, :body => File.open(SPEC_ROOT + "/fixtures/quotas.json").read, :headers => {})
  end
end

describe IsilonApi::Quotas do
  before do
    @conn = IsilonApi::Base.new.connection
    @quotas = described_class.new @conn
  end

  describe '#list' do
    it 'returns an array' do
      expect(@quotas.list).to be_an Array
    end

    it 'array items are instance of quota' do
      expect(@quotas.list.first).to be_an IsilonApi::Quota
    end
  end
end
