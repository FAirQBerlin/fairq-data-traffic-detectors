with monthly_avg as (
	select mq_name, year(tag) Jahr, month(tag) Monat, avg(q_kfz_mq_hr) mittl_monatswert
	from traffic_det_observations
	where  q_kfz_mq_hr != -1
	group by mq_name, Jahr, Monat
)

select
	Jahr,
	Monat,
	quantile(0.01)(mittl_monatswert) perz_01,
	quantile(0.10)(mittl_monatswert) perz_10,
	quantile(0.25)(mittl_monatswert) perz_25,
	quantile(0.50)(mittl_monatswert) perz_50,
	avg(mittl_monatswert) mean,
	quantile(0.75)(mittl_monatswert) perz_75,
	quantile(0.90)(mittl_monatswert) perz_90,
	quantile(0.99)(mittl_monatswert) perz_99
from
	monthly_avg da
-- Use only detectors with known metadata (coordinates, ...):
inner join traffic_det_cross_sections cs
on
	da.mq_name = cs.mq_short_name
group by
	Jahr,
	Monat;
