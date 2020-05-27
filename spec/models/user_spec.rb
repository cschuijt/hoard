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
      user = create(:user, uid: "12345678")
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

  context "commissions" do
    it "should return a user's commissions" do
      user = create(:user)
      commission  = create(:commission, user: user)
      commission2 = create(:commission, user: user)

      expect(user.commissions).to include(commission)
      expect(user.commissions).to include(commission2)
    end

    it "should not return another user's commissions" do
      commission = create(:commission)
      user = create(:user)

      expect(user.commissions).not_to include(commission)
    end
  end

  context "folders" do
    it "should return a user's folders" do
      user = create(:user)
      folder  = create(:folder, user: user)
      folder2 = create(:folder, user: user)

      expect(user.folders).to include(folder)
      expect(user.folders).to include(folder2)
    end

    it "should not return another user's folders" do
      folder = create(:folder)
      user = create(:user)

      expect(user.folders).not_to include(folder)
    end
  end

  context "omniauth callback" do
    it "should match a user with the same uid" do
      user = create(:user, uid: "1234")
      authentication_hash = { provider: "twitter", uid: "1234", info:
                            { nickname: "asdf",    name: "Asdf", image: "fuck" } }

      expect(User.from_omniauth(authentication_hash)).to eq(user)
    end

    it "should create a new user for an unknown uid" do
      authentication_hash = { provider: "twitter", uid: "70", info:
                            { nickname: "asdf",    name: "Asdf", image: "fuck" } }

      expect(User.from_omniauth(authentication_hash)).to be_a_new(User)
    end

    it "should edit the user's details" do
      create(:user, uid: "1234", name: "Asdf")
      authentication_hash = { provider: "twitter", uid: "1234", info:
                            { nickname: "asdf",    name: "Qwer", image: "fuck" } }

      user = User.from_omniauth(authentication_hash)

      expect(user.name).to eq("Qwer")
      expect(user.name).not_to eq("Asdf")
    end
  end
end
