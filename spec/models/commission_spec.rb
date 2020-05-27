require 'rails_helper'

RSpec.describe Commission, type: :model do
  context "with valid data" do
    it "should be valid" do
      commission = build(:commission)

      expect(commission).to be_valid
    end
  end

  context "title" do
    it "should not be nil" do
      commission = build(:commission, title: nil)
      expect(commission).to be_invalid
    end

    it "should not be empty" do
      commission = build(:commission, title: "")
      expect(commission).to be_invalid
    end

    it "should not be blank" do
      commission = build(:commission, title: "      ")
      expect(commission).to be_invalid
    end

    it "should not be too short" do
      commission = build(:commission, title: "As")
      expect(commission).to be_invalid
    end

    it "should not be too long" do
      commission = build(:commission, title: "A"*200)
      expect(commission).to be_invalid
    end
  end

  context "description" do
    it "should not be too long" do
      commission = build(:commission, description: "A"*20001)
      expect(commission).to be_invalid
    end
  end

  context "user association" do
    it "should not be missing" do
      commission = build(:commission, user: nil)
      expect(commission).to be_invalid
    end
  end
end
