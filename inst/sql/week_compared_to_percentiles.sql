-- Average for each week and year
with
week_avg_by_year as (
select
	toWeek(tag) woche,
	toYear(tag) jahr,
	toStartOfWeek(tag) start_of_week,
	avg(q_kfz_mq_hr) mittl_wochenwert
from
	traffic_det_observations tdo
inner join traffic_det_cross_sections cs
on
	tdo.mq_name = cs.mq_short_name
where
	q_kfz_mq_hr != -1
group by
	jahr,
	woche,
	start_of_week
),
-- Percentiles für each week of the year (over all years)
week_avg_overall as (
select
	woche,
	quantile(0.10)(mittl_wochenwert) perz_10,
	quantile(0.50)(mittl_wochenwert) perz_50,
	quantile(0.90)(mittl_wochenwert) perz_90
from
	week_avg_by_year
	where (jahr < 2020) or (jahr = 2021 and woche > 16) or (jahr > 2021)
group by
	woche)

select
	*
from
	week_avg_by_year
left join week_avg_overall
		using(woche)
order by
	jahr,
	woche;
