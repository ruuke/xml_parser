require 'rails_helper'

describe Batch, type: :model do
  subject { build :batch }

  it { should have_many(:invoices) }

  it { should validate_presence_of :id }
  it { should validate_uniqueness_of :id }
  it { should validate_numericality_of :id }
  it { should allow_value(1234567).for(:id) }

  it { should validate_presence_of :creation_date }

  it { should validate_presence_of :guid }
  it { should validate_uniqueness_of :guid }

  it 'have one attached file' do
    expect(Batch.new.file).to be_an_instance_of(ActiveStorage::Attached::One)
  end

  it "should validate associate invoice" do
    subject.invoices.build()
    subject.save.should eq(false)
  end
end
