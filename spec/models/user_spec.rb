require 'rails_helper'

RSpec.describe User, type: :model do
  context "with valid data" do
    it "should be valid" do
      user = build(:user)
      expect(user).to be_valid
    end
  end

  context "username" do
    it "should not be nil" do
      user = build(:user, username: nil)
      expect(user).to be_invalid
    end

    it "should not be blank" do
      user = build(:user, username: "")
      expect(user).to be_invalid
    end
  end

  context "UID" do
    it "should not be nil" do
      user = build(:user, uid: nil)
      expect(user).to be_invalid
    end

    it "should not be blank" do
      user = build(:user, uid: "")
      expect(user).to be_invalid
    end

    it "should be unique" do
      user = build(:user, uid: "12345678")
      user.save

      user2 = build(:user, uid: "12345678")
      expect(user2).to be_invalid
    end
  end

  context "nickname" do
    it "should not be nil" do
      user = build(:user, name: nil)
      expect(user).to be_invalid
    end

    it "should not be blank" do
      user = build(:user, name: "")
      expect(user).to be_invalid
    end
  end
end
