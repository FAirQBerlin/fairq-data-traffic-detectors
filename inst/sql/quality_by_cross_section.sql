select
	mq_name,
	avg(qualitaet) Mittl_Qualitaet,
	count(*) Anzahl_Zeilen
from
	traffic_det_observations o
inner join traffic_det_cross_sections cs
on
	o.mq_name = cs.mq_short_name
group by
	mq_name
order by
	mq_name;
