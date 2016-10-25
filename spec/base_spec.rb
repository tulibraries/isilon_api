require 'spec_helper'



describe IsilonApi::Base do
  before(:all) do
    @config = IsilonApi.configuration
    stub_request(:get, "https://isilon.example.com:8080/platform/1/quota/quotas").with(basic_auth: [@config.user, @config.password]).
        to_return(:status => 200, :body => File.open(SPEC_ROOT + "/fixtures/quotas.json").read, :headers => {})

  end

  describe '#get_quotas' do
    before do
      @response = described_class.new.get_quotas

    end
    it 'sends a request to the Isilon API' do
      expect(@response.body).to be_an_instance_of(String)

    end
  end


end