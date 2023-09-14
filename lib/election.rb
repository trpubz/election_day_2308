class Election
  attr_reader :year, :races

  def initialize(year)
    @year = year
    @races = []
  end

  def add_race(race)
    @races << race
  end

  def candidates
    @races.flat_map { |race| race.candidates}
  end

  def vote_counts
    self.candidates.reduce(0) { |tot_votes, candidate| tot_votes + candidate.votes }
  end
end
