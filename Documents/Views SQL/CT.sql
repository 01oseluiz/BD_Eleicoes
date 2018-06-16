select
	(select count(candidates.idCandidate)
	from Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo
    where cargoName = 'Presidente') as NúmeroPresidentes,
    (select count(candidates.idCandidate)
	from Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo
    where cargoName = 'Governador') as NúmeroGovernadores,
    (select count(candidates.idCandidate)
	from Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo
    where cargoName = 'Senador')  as NúmeroSenadores,
    (select count(candidates.idCandidate)
	from Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo
    where cargoName = 'Deputado Federal') as NúmeroDeputadosFederais,
    (select count(candidates.idCandidate)
	from Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo
    where cargoName = 'Deputado Estadual/Distrital') as NúmeroDeputadosEstaduais_Distritais;