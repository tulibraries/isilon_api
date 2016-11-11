# quota_report_spec.rb
#
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
        @quota.usage,
        @quota.free_space,
        @quota.soft_limit,
        @quota.hard_limit,
        @quota.percent_used,
        Float(@quota.usage) / @quota.isilon_total_size
      ]
    end

  end

  context 'quota report' do
    before do
    end

    it 'writes a report' do
      @report = IsilonApi::Report.new("report.csv")
    end
  end
end
