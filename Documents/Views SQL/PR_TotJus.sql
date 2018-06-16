/*select count(electors.idElector) as TotalJustificados, regions.regionName as NomeRegião  -- Total Justificados
	from ((((((Elections.round_electors 	inner join Elections.electors on round_electors.idElector = electors.idElector)
											inner join Elections.zones on electors.idZone = zones.idZone)
											inner join Elections.addresses on zones.idAddress = addresses.idAddress)
											inner join Elections.cities on addresses.idCity = cities.idCity)
											inner join Elections.states on cities.idState = states.idState)
											inner join Elections.regions on states.idRegion = regions.idRegion)
	where electorJustified = '1'
    group by NomeRegião;*/

select
	(select count(electors.idElector) -- Total Justificados
		from ((((((Elections.round_electors 	inner join Elections.electors on round_electors.idElector = electors.idElector)
												inner join Elections.zones on electors.idZone = zones.idZone)
												inner join Elections.addresses on zones.idAddress = addresses.idAddress)
												inner join Elections.cities on addresses.idCity = cities.idCity)
												inner join Elections.states on cities.idState = states.idState)
												inner join Elections.regions on states.idRegion = regions.idRegion)
		where electorJustified = '1'
												) as TotalJustificados,
	regions.regionName as NomeRegião from Elections.regions -- Regiões
    group by NomeRegião;