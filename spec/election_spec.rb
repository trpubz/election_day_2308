require "spec_helper"

RSpec.describe Election do
  before(:each) do
    @election = Election.new("2024")
    @race1 = Race.new("Texas Governor")
    @race2 = Race.new("Arizona Governor")
    @candidate1 = @race1.register_candidate!({name: "Diana D", party: :democrat})
    @candidate2 = @race1.register_candidate!({name: "Roberto R", party: :republican})
    @candidate3 = @race2.register_candidate!({name: "TP", party: "Free Masons"})
    @candidate4 = @race2.register_candidate!({name: "DumbDumb", party: "Free Thinkers"})
  end

  describe "#initialize" do
    it "exists" do
      expect(@election).to be_an Election
    end
  end

  describe "#year" do
    it "access @year" do
      expect(@election.year).to eq "2024"
    end
  end

  describe "#races" do
    it "access @races" do
      expect(@election.races).to eq []
    end
  end

  describe "#add_race" do
    it "adds" do
      @election.add_race(@race1)
      expect(@election.races).to eq [@race1]
    end
  end

  describe "#candidates" do
    it "returns all candidates from all races" do
      @election.add_race(@race1)
      expect(@election.candidates).to eq [@candidate1, @candidate2]
      @election.add_race(@race2)
      expect(@election.candidates).to eq [@candidate1, @candidate2, @candidate3, @candidate4]
    end
  end

  describe "#vote_counts" do
    it "counts all votes from all candidates in all races" do
      @election.add_race(@race1)
      @election.add_race(@race2)
      @election.candidates.each { |candidate| 3.times { candidate.vote_for! } }
      expect(@election.vote_counts).to eq 12
    end
  end

  describe "#winners" do
    it "returns winners from each race" do
      3.times {
        @candidate1.vote_for!
        @candidate3.vote_for!
      }
      @election.add_race(@race1)
      @election.add_race(@race2)
      @race1.close!
      @race2.close!
      expect(@election.winners).to eq [@candidate1, @candidate3]
    end

    it "returns winners from only closed races" do
      3.times {
        @candidate1.vote_for!
        @candidate3.vote_for!
      }
      @election.add_race(@race1)
      @election.add_race(@race2)
      @race2.close!
      expect(@election.winners).to eq [@candidate3]
    end
  end
end
