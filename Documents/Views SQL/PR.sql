select
	(select count(electors.idElector) -- Total Eleitores
	from (((((Elections.electors	inner join Elections.zones on electors.idZone = zones.idZone)
									inner join Elections.addresses on zones.idAddress = addresses.idAddress)
									inner join Elections.cities on addresses.idCity = cities.idCity)
									inner join Elections.states on cities.idState = states.idState)
									inner join Elections.regions on states.idRegion = regions.idRegion)
                                    ) as TotalEleitores,
	(select count(electors.idElector) -- Total Compareceu
	from ((((((Elections.round_electors 	inner join Elections.electors on round_electors.idElector = electors.idElector)
											inner join Elections.zones on electors.idZone = zones.idZone)
											inner join Elections.addresses on zones.idAddress = addresses.idAddress)
											inner join Elections.cities on addresses.idCity = cities.idCity)
											inner join Elections.states on cities.idState = states.idState)
											inner join Elections.regions on states.idRegion = regions.idRegion)
	where electorVoted = '1'
											) as TotalCompareceu,
	(select count(electors.idElector) -- Total Justificados
	from ((((((Elections.round_electors 	inner join Elections.electors on round_electors.idElector = electors.idElector)
											inner join Elections.zones on electors.idZone = zones.idZone)
											inner join Elections.addresses on zones.idAddress = addresses.idAddress)
											inner join Elections.cities on addresses.idCity = cities.idCity)
											inner join Elections.states on cities.idState = states.idState)
											inner join Elections.regions on states.idRegion = regions.idRegion)
	where electorJustified = '1'
											) as TotalJustificados,
	(select count(zone_candidates.idVote) -- Votos Válidos
	from (((((Elections.zone_candidates	inner join Elections.zones on zone_candidates.idZone = zones.idZone)
										inner join Elections.addresses on zones.idAddress = addresses.idAddress)
										inner join Elections.cities on addresses.idCity = cities.idCity)
										inner join Elections.states on cities.idState = states.idState)
                                        inner join Elections.regions on states.idRegion = regions.idRegion)
	where zone_candidates.idCandidate != '1' and zone_candidates.idCandidate != '0'
										) as VotosVálidos,
	(select count(zone_candidates.idVote) -- Votos Manuais
	from (((((Elections.zone_candidates	inner join Elections.zones on zone_candidates.idZone = zones.idZone)
										inner join Elections.addresses on zones.idAddress = addresses.idAddress)
										inner join Elections.cities on addresses.idCity = cities.idCity)
										inner join Elections.states on cities.idState = states.idState)
                                        inner join Elections.regions on states.idRegion = regions.idRegion)
	where zone_candidates.voteIsManual = '1'
										) as VotosManuais,
	regions.regionName as NomeRegião from Elections.regions -- Regiões
    group by NomeRegião;