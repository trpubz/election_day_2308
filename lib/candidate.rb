class Candidate
  attr_reader :name,
    :party,
    :votes

  def initialize(name, party)
    @name = name
    @party = party
    @votes = 0
  end

  def vote_for!
    @votes += 1
  end
end
