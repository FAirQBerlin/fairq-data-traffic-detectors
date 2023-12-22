select
	mq_name,
	count(*) Anzahl_Zeilen,
	min(tag) Messbeginn,
	max(tag) Messende,
	date_diff('hour', Messbeginn, Messende) Messzeitraum,
	round(Anzahl_Zeilen / Messzeitraum, 1) Anteil_vorhandene_Werte
from
	traffic_det_observations
group by
	mq_name
order by
	Anteil_vorhandene_Werte desc;
