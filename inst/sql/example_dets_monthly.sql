select
	m.mq_name mq_name,
	stat.station_name station_name,
	year(tag) Jahr,
	month(tag) Monat,
	sum(q_kfz_mq_hr) Anzahl_Gesamt
from
	traffic_det_observations tdo
inner join
  mapping_messstationen_traffic_det m using(mq_name)
inner join messstationen stat on(m.station_id = stat.station_id)
where mq_name in ('TE384', 'TE385', 'TE014', 'TE530', 'TE386', 'TE395', 'TE393', 'TE394')
group by
	m.mq_name,
	stat.station_name,
	Jahr,
	Monat;
