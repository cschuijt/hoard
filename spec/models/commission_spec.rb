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

  context "start method" do
    before(:example) do
      @commission = create(:commission, started: false)
      @commission.start
    end

    it "should start a commission that hasn't been started yet" do
      expect(@commission.started?).to eq(true)
    end

    it "should set started_at to the current time" do
      expect(@commission.started_at).to be_within(1.minute).of(Time.now)
    end
  end

  context "finish method" do
    before(:example) do
      @commission = create(:commission, finished: false)
      @commission.finish
    end

    it "should finish a commission that hasn't been finished yet" do
      expect(@commission.finished?).to eq(true)
    end

    it "should set finished_at to the current time" do
      # 1.second should also work, but brittle tests bad.
      expect(@commission.finished_at).to be_within(1.minute).of(Time.now)
    end
  end
end
