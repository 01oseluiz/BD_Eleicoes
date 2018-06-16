select count(candidates.idCandidate) as NúmeroPresidentes
	from Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo
    where cargoName = 'Presidente';