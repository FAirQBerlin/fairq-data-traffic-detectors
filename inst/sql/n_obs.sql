select
	count(*)
from
	traffic_det_observations
where tag < toStartOfMonth(now());
