create view PartidoMaisVotado as
select
	(select count(candidates.idCandidate) -- Número de Candidatos
		from (Elections.candidates 	inner join Elections.parties on candidates.idParty = parties.idParty)
									) as NúmeroCandidatos,
	(select count(zone_candidates.idVote) -- Número de Votos
		from (Elections.zone_candidates inner join Elections.candidates on zone_candidates.idCandidate = candidates.idCandidate)
										inner join Elections.parties on candidates.idParty = parties.idParty
										) as NúmeroVotos,
	parties.partyName as NomePartido from Elections.parties
	group by NomePartido;