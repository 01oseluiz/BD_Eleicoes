select
(select count(electors.idElector) from Elections.electors) - (select count(round_electors.idElector) from Elections.round_electors)
as TotalFaltosos;