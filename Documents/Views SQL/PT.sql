create view ParticipacaoTotal as
select
	(select count(electors.idElector) from Elections.electors) as TotalEleitores, -- Total Eleitores
	(select count(round_electors.idElector) from Elections.round_electors -- Total Compareceu
	where round_electors.electorVoted = '1') as TotalCompareceu,
	(select -- Total Faltosos
	(select count(electors.idElector) from Elections.electors) - (select count(round_electors.idElector) from Elections.round_electors)) as TotalFaltosos,
	(select count(round_electors.idElector) from Elections.round_electors -- Total Justificados
	where round_electors.electorJustified = '1') as TotalJustificados,
	(select count(zone_candidates.idVote) as VotosVálidos from Elections.zone_candidates -- Votos Válidos
	where zone_candidates.idCandidate != '1' and zone_candidates.idCandidate != '0') as VotosVálidos,
	(select count(zone_candidates.idVote) from Elections.zone_candidates -- Votos Manuais
	where zone_candidates.voteIsManual = '1')  as VotosManuais;