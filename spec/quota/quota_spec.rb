describe IsilonApi::Quota do
  before do
    raw = JSON.load(open(File.join(SPEC_ROOT, 'fixtures', 'single_quota.json')))
    @quota = described_class.new :quota => raw
  end

it 'displays the share name' do
  expect(@quota.name).to eql 'deposit'
end

it 'displays the path to the share' do
  expect(@quota.path).to eql '/ifs/data/libraryfs/deposit'
end

it 'displays current usage' do
  expect(@quota.usage).to eql 25672323350645
end

it 'displays hard limt' do
  expect(@quota.hard_limit).to eql 28587302322176
end

it 'displays soft limit' do
  expect(@quota.soft_limit).to eql 27487790694400
end

it 'provides total used percentage' do
  expect(@quota.percent_used).to eq 0.89
end

it 'calculates free space remaining' do
  expect(@quota.free_space).to eql 2914978971531
end


end
