select
	mq_name,
	avgIf(q_kfz_mq_hr, q_kfz_mq_hr != -1) Mittl_Anzahl_Gesamt,
	avgIf(q_pkw_mq_hr, q_pkw_mq_hr != -1) Mittl_Anzahl_PKW,
	avgIf(q_lkw_mq_hr, q_lkw_mq_hr != -1) Mittl_Anzahl_LKW,
	avgIf(v_kfz_mq_hr, v_kfz_mq_hr != -1) Mittl_Tempo_Gesamt,
	avgIf(v_pkw_mq_hr, v_pkw_mq_hr != -1) Mittl_Tempo_PKW,
	avgIf(v_lkw_mq_hr, v_lkw_mq_hr != -1) Mittl_Tempo_LKW
from
	traffic_det_observations o
inner join traffic_det_cross_sections cs
on
	o.mq_name = cs.mq_short_name
group by
	mq_name;
