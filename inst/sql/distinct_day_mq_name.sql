select
	distinct
	mq_name,
	tag Tag
from
	traffic_det_observations o
inner join traffic_det_cross_sections cs
on
	o.mq_name = cs.mq_short_name;
