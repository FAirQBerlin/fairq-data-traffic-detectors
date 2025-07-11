select
	mq_name,
	year(tag) Jahr,
	month(tag) Monat,
	avg(q_kfz_mq_hr) mittl_monatswert
from
	traffic_det_observations tdo
inner join traffic_det_cross_sections cs
on
	tdo.mq_name = cs.mq_short_name
where
	q_kfz_mq_hr != -1
  and tag < toStartOfMonth(now())
group by
	mq_name,
	Jahr,
	Monat
;
