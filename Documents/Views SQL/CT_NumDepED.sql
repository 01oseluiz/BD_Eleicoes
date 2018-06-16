select count(candidates.idCandidate) as NúmeroDeputadosEstaduais_Distritais
	from Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo
    where cargoName = 'Deputado Estadual/Distrital';