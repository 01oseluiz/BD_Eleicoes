select count(candidates.idCandidate) as NúmeroGovernadores, parties.partyName as NomePartido -- Número Governadores
	from ((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
								inner join Elections.parties on candidates.idParty = parties.idParty)
	where cargoName = 'Governador'
    group by NomePartido;
