select
	qualitaet Qualitaet
from
	traffic_det_observations o
inner join traffic_det_cross_sections cs
on
	o.mq_name = cs.mq_short_name;
