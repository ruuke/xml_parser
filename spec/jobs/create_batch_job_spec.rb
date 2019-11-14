require 'rails_helper'

describe CreateBatchJob, type: :job do
  let(:batch) { create :batch }

  before do
    expect(XmlParserService).to receive(:new).with(batch).and_call_original
    expect_any_instance_of(XmlParserService).to receive(:call)
  end

  it { described_class.perform_now(batch) }
end
