require 'spec_helper'

RSpec.configure do |config|
  config.before(:each) do
    @config = IsilonApi.configuration
    stub_request(:get, "https://isilon.example.com:8080/platform/1/quota/quotas").with(basic_auth: [@config.user, @config.password]).
        to_return(:status => 200, :body => File.open(SPEC_ROOT + "/fixtures/quotas.json").read, :headers => {})
  end
end

RSpec.describe IsilonApi::Report do
  require "isilon_api/quota/quota"

  context 'quota conversion' do
    before do
      raw = JSON.load(open(File.join(SPEC_ROOT, 'fixtures', 'single_quota.json')))
      @quota = IsilonApi::Quota.new :quota => raw
      allow(@quota).to receive(:isilon_total_size) { 1.0E+15 }
    end

    it 'displays quota array' do
      expect(IsilonApi::Report.to_array(@quota)).to match_array [
        @quota.name,
        @quota.path,
        (@quota.usage / 1.0E+6).round(2),
        (@quota.free_space / 1.0E+6).round(2),
        (@quota.soft_limit / 1.0E+6).round(2),
        (@quota.hard_limit / 1.0E+6).round(2),
        (@quota.percent_used * 100).round(2),
        (@quota.usage / @quota.isilon_total_size).round(2)
      ]
    end

  end

  describe 'quota report' do
    it 'writes a report' do
      csv_filename = "report.csv"
      IsilonApi::Report.generate_csv (csv_filename)
    end
  end
end
