create view CandidatosTotal as
select
	(select count(candidates.idCandidate) -- Número Presidentes
	from Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo
    where cargoName = 'Presidente') as NúmeroPresidentes,
    (select count(candidates.idCandidate) -- Número Governadores
	from Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo
    where cargoName = 'Governador') as NúmeroGovernadores,
    (select count(candidates.idCandidate) -- Número Senadores
	from Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo
    where cargoName = 'Senador')  as NúmeroSenadores,
    (select count(candidates.idCandidate) -- Número Deputados Federais
	from Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo
    where cargoName = 'Deputado Federal') as NúmeroDeputadosFederais,
    (select count(candidates.idCandidate) -- Número Deputados Estaduais/Distritais
	from Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo
    where cargoName = 'Deputado Estadual/Distrital') as NúmeroDeputadosEstaduais_Distritais;