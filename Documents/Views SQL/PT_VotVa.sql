select count(zone_candidates.idVote) as VotosVálidos from Elections.zone_candidates
where zone_candidates.idCandidate != '1' and zone_candidates.idCandidate != '0';
