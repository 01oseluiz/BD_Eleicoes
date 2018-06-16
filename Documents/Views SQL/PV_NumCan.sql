select
	(select count(candidates.idCandidate)
		from (Elections.candidates 	inner join Elections.parties on candidates.idParty = parties.idParty)
									) as NúmeroCandidatos,
	parties.partyName as NomePartido from Elections.parties
	group by NomePartido;