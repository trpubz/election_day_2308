require "candidate"

class Race
  attr_reader :office, :candidates

  def initialize(office)
    @office = office
    @candidates = []
    @open = true
  end

  def register_candidate!(candidate)
    @candidates << Candidate.new(candidate)
    @candidates.last
  end

  def open?
    @open
  end

  def close!
    @open = false
  end

  def winner
    if open?
      false
    else
      @candidates.max_by { |candidate| candidate.votes }
    end
  end

  def tie?
    if open?
      puts "race is still open"
    else
      highest = @candidates.max_by(2) { |candidate| candidate.votes }
      highest.reduce { |a, b| a.votes == b.votes }
    end
  end
end
