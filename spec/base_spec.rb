require 'spec_helper'

describe IsilonApi::Base do
  before do
    @base = IsilonApi::Base.new
  end

  describe '#base_uri' do
    it 'creates the expected base url' do
      expect(@base.base_uri).to eql "https://isilon.example.com:8080"
    end
  end
end
