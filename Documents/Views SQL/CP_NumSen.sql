select count(candidates.idCandidate) as NúmeroSenadores, parties.partyName as NomePartido -- Número Senadores
	from ((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
								inner join Elections.parties on candidates.idParty = parties.idParty)
	where cargoName = 'Senador'
    group by NomePartido;
