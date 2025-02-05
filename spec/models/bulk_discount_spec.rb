require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do

  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:items).through(:merchant) }
    it { should have_many(:invoices).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity).is_greater_than(0) }
    it { should validate_presence_of(:discount) }
    it { should validate_numericality_of(:discount).is_greater_than(0).is_less_than_or_equal_to(100) }
  end
end
