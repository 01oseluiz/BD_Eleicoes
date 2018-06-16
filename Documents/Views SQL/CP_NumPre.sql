select count(candidates.idCandidate) as NúmeroPresidentes, parties.partyName as NomePartido -- Número Presidentes
	from ((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
								inner join Elections.parties on candidates.idParty = parties.idParty)
	where cargoName = 'Presidente'
    group by NomePartido;
