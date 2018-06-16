-- Total Eleitores
/*select count(electors.idElector) as TotalEleitores, states.stateName as NomeEstado
from ((((Elections.electors	inner join Elections.zones on electors.idZone = zones.idZone)
							inner join Elections.addresses on zones.idAddress = addresses.idAddress)
                            inner join Elections.cities on addresses.idCity = cities.idCity)
                            inner join Elections.states on cities.idState = states.idState)
group by NomeEstado;*/

select 
	(select count(electors.idElector) -- Total Eleitores
		from ((((Elections.electors	inner join Elections.zones on electors.idZone = zones.idZone)
									inner join Elections.addresses on zones.idAddress = addresses.idAddress)
									inner join Elections.cities on addresses.idCity = cities.idCity)
									inner join Elections.states on cities.idState = states.idState)
									) as TotalEleitores,
	states.stateName as NomeEstado from Elections.states -- Estados
	group by NomeEstado;