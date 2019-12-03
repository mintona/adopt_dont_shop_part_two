require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :content }
    it { should validate_presence_of :shelter }
    # it { should validate_presence_of :image } - this is optional - need research how to do this
  end

  describe "relationships" do
    it { should belong_to :shelter }
  end
end