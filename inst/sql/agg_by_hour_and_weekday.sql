select
	stunde Stunde,
	formatDateTime(tag, '%u') Wochentag, -- Monday will be 1
	count(distinct(mq_name)) Anzahl_Messquerschnitte,
	count(*) Anzahl_Zeilen,
	sumIf(q_kfz_mq_hr, q_kfz_mq_hr != -1) Anzahl_Gesamt,
	sumIf(q_pkw_mq_hr, q_pkw_mq_hr != -1) Anzahl_PKW,
	sumIf(q_lkw_mq_hr, q_lkw_mq_hr != -1) Anzahl_LKW,
	avgIf(v_kfz_mq_hr, v_kfz_mq_hr != -1) Mittl_Tempo_Gesamt,
	avgIf(v_pkw_mq_hr, v_pkw_mq_hr != -1) Mittl_Tempo_PKW,
	avgIf(v_lkw_mq_hr, v_lkw_mq_hr != -1) Mittl_Tempo_LKW,
	avg(qualitaet) Mittl_Qualitaet
from
	traffic_det_observations o
-- Use only detectors with known metadata (coordinates, ...):
inner join traffic_det_cross_sections sd
on
	o.mq_name = sd.mq_short_name
group by
	Stunde,
	Wochentag
order by
	Stunde,
	Wochentag;
