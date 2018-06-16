/*select count(electors.idElector) as TotalEleitores, regions.regionName as NomeRegião -- Total Eleitores
	from (((((Elections.electors	inner join Elections.zones on electors.idZone = zones.idZone)
									inner join Elections.addresses on zones.idAddress = addresses.idAddress)
									inner join Elections.cities on addresses.idCity = cities.idCity)
									inner join Elections.states on cities.idState = states.idState)
									inner join Elections.regions on states.idRegion = regions.idRegion)
	group by NomeRegião;*/
    
select
	(select count(electors.idElector) -- Total Eleitores
		from (((((Elections.electors	inner join Elections.zones on electors.idZone = zones.idZone)
										inner join Elections.addresses on zones.idAddress = addresses.idAddress)
										inner join Elections.cities on addresses.idCity = cities.idCity)
										inner join Elections.states on cities.idState = states.idState)
										inner join Elections.regions on states.idRegion = regions.idRegion)
										) as TotalEleitores,
	regions.regionName as NomeRegião from Elections.regions -- Regiões
    group by NomeRegião;