insert into analysis.dm_rfm_segments (
	select user_id, recency, frequency, monetary_value
	from analysis.tmp_rfm_recency trr 
	join analysis.tmp_rfm_frequency trf using(user_id)
	join analysis.tmp_rfm_monetary_value trmv using(user_id)
)
