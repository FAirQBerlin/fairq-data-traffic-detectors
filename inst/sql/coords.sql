select
	o.mq_name,
	lon,
	lat,
	count(*) Anzahl_Zeilen
from
	traffic_det_observations o
left join traffic_det_cross_sections cs
on
	o.mq_name = cs.mq_short_name
group by 
	mq_name,
	lon,
	lat;
