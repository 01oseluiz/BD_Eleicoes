module WelcomeHelper
  def get_candidate(id_cargo, id_estado, id_round)
    @ret = ActiveRecord::Base.connection.select_all("call get_candidates(#{id_estado},#{id_cargo},#{id_round});")
    @cand = Candidate.none

    @ret.to_hash.each do |candidate|
      @cand = @cand + [Candidate.new(candidate)]
    end
    @cand
  end

end
