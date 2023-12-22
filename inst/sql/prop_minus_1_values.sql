select
	avg(qualitaet = -1),
	avg(q_kfz_mq_hr = -1),
	avg(q_pkw_mq_hr = -1),
	avg(q_lkw_mq_hr = -1),
	avgIf(v_kfz_mq_hr = -1, q_kfz_mq_hr > 0),
	avgIf(v_pkw_mq_hr = -1, q_pkw_mq_hr > 0),
	avgIf(v_lkw_mq_hr = -1, q_lkw_mq_hr > 0)
from
	traffic_det_observations;
