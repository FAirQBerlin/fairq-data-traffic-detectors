select
	dto.mq_name mq_name, tag, stunde, q_kfz_mq_hr, stat.station_name station_name 
from
	traffic_det_observations dto
inner join mapping_messstationen_traffic_det m using(mq_name)
inner join messstationen stat on(m.station_id = stat.station_id)
where mq_name in ('TE384', 'TE385', 'TE014', 'TE530', 'TE386', 'TE395', 'TE393', 'TE394');
