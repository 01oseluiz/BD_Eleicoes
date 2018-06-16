select
	(select count(zone_candidates.idVote) 
		from (Elections.zone_candidates inner join Elections.candidates on zone_candidates.idCandidate = candidates.idCandidate)
										inner join Elections.parties on candidates.idParty = parties.idParty
										) as NúmeroVotos,
	parties.partyName as NomePartido from Elections.parties
	group by NomePartido;