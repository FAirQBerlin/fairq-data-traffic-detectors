select
	year(tag) Jahr,
	month(tag) Monat,
	avgIf(v_pkw_mq_hr == -1, q_pkw_mq_hr > 0) Anteil_minus_1_v_pkw
from
	traffic_det_observations o
-- Use only detectors with known metadata (coordinates, ...):
inner join traffic_det_cross_sections cs
on
	o.mq_name = cs.mq_short_name
group by
	Jahr,
	Monat
order by
	Jahr,
	Monat;
