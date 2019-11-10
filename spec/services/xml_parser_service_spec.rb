require 'spec_helper'
require 'rails_helper'

describe XmlParserService do
  let(:batch) { create :batch, :with_file }
  subject { described_class.call(batch) }

  it { expect { subject }.to change { Batch.count }.by(1) }
end
