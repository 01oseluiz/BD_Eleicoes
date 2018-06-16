select count(zone_candidates.idVote) as VotosManuais from Elections.zone_candidates
where zone_candidates.voteIsManual = '1';

