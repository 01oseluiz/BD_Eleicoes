select count(candidates.idCandidate) as NúmeroDeputadosFederais
	from Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo
    where cargoName = 'Deputado Federal';