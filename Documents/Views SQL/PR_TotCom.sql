/*select count(electors.idElector) as TotalCompareceu, regions.regionName as NomeRegião -- Total Compareceu
	from ((((((Elections.round_electors 	inner join Elections.electors on round_electors.idElector = electors.idElector)
											inner join Elections.zones on electors.idZone = zones.idZone)
											inner join Elections.addresses on zones.idAddress = addresses.idAddress)
											inner join Elections.cities on addresses.idCity = cities.idCity)
											inner join Elections.states on cities.idState = states.idState)
											inner join Elections.regions on states.idRegion = regions.idRegion)
	where electorVoted = '1'
    group by NomeRegião;*/

select
	(select count(electors.idElector) -- Total Compareceu
		from ((((((Elections.round_electors 	inner join Elections.electors on round_electors.idElector = electors.idElector)
												inner join Elections.zones on electors.idZone = zones.idZone)
												inner join Elections.addresses on zones.idAddress = addresses.idAddress)
												inner join Elections.cities on addresses.idCity = cities.idCity)
												inner join Elections.states on cities.idState = states.idState)
												inner join Elections.regions on states.idRegion = regions.idRegion)
		where electorVoted = '1'
												) as TotalCompareceu,
	regions.regionName as NomeRegião from Elections.regions -- Regiões
    group by NomeRegião;