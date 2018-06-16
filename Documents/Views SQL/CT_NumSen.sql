select count(candidates.idCandidate) as NúmeroSenadores
	from Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo
    where cargoName = 'Senador';