require 'rails_helper'

RSpec.describe Folder, type: :model do
  context "with valid data" do
    it "should be valid" do
      folder = build(:folder)
      expect(folder).to be_valid
    end
  end

  context "title" do
    it "should not be nil" do
      folder = build(:folder, title: nil)
      expect(folder).to be_invalid
    end

    it "should not be empty" do
      folder = build(:folder, title: "")
      expect(folder).to be_invalid
    end

    it "should not be blank" do
      folder = build(:folder, title: "      ")
      expect(folder).to be_invalid
    end

    it "should not be too short" do
      folder = build(:folder, title: "As")
      expect(folder).to be_invalid
    end

    it "should not be too long" do
      folder = build(:folder, title: "A"*200)
      expect(folder).to be_invalid
    end
  end

  context "user association" do
    it "should not be missing" do
      folder = build(:folder, user: nil)
      expect(folder).to be_invalid
    end
  end
end
