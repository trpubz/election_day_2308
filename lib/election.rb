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
    @races.flat_map { |race| race.candidates }
  end

  def vote_counts
    candidates.reduce(0) { |tot_votes, candidate| tot_votes + candidate.votes }
  end

  def winners
    winners = []
    @races.each do |race|
      unless race.open? || race.tie?
        winners << race.winner
      end
    end
    winners
  end
end
