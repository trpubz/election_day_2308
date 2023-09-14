require "spec_helper"

RSpec.describe Race do
  before(:each) do
    @race = Race.new("Texas Governor")
    @candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
    @candidate2 = @race.register_candidate!({name: "Roberto R", party: :republican})
  end

  describe "#initialize" do
    it "exists" do
      expect(@race).to be_a Race
    end

    it "has @attr" do
      expect(@race.office).to eq "Texas Governor"
      expect(@race.candidates).to be_a Array
      expect(@race.open?).to eq true
    end
  end

  describe "#register_candidate!" do
    it "registers & returns ::candidates" do
      expect(@candidate1).to be_a Candidate
      expect(@candidate1.name).to eq "Diana D"
      expect(@candidate1.party).to eq :democrat
      expect(@race.candidates).to eq [@candidate1, @candidate2]
    end
  end

  describe "#close!" do
    it "closes the race" do
      @race.close!
      expect(@race.open?).to eq false
    end
  end

  describe "#winner" do
    it "returns candidate with most votes if race != open" do
      expect(@race.winner).to eq false
      3.times { @candidate2.vote_for! }
      2.times { @candidate1.vote_for! }
      @race.close!
      expect(@race.winner).to eq @candidate2
    end
  end

  describe "tie?" do
    it "returns true if >1 candidate has highest votes" do
      3.times { @candidate2.vote_for! }
      3.times { @candidate1.vote_for! }
      @race.close!
      expect(@race.tie?).to eq true
    end

    it "returns false if 1 candidate has highest votes" do
      3.times { @candidate2.vote_for! }
      2.times { @candidate1.vote_for! }
      @race.close!
      expect(@race.tie?).to eq false
    end
  end
end
