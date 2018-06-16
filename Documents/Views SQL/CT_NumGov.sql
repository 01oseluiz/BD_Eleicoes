select count(candidates.idCandidate) as NúmeroGovernadores
	from Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo
    where cargoName = 'Governador';