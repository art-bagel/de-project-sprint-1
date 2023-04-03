-- Код к задаче 1
insert into analysis.tmp_rfm_recency (
	with orders_new as (
		select o.user_id, o.order_ts,  o.payment
		from orders o
		join orderstatuses os on o.status = os.id
		where os.key = 'Closed' and extract(year FROM o.order_ts) = 2022
	), last_order_date as (
		select distinct on (u.id) u.id as user_id, o.order_ts
		from users u
		left join orders_new o on u.id = o.user_id 
		order by user_id, order_ts desc
	)
	select user_id, NTILE(5) OVER( ORDER BY order_ts ASC nulls First ) as recency
	from last_order_date 
);
-- Код к задаче 2
insert into analysis.tmp_rfm_recency (
			with orders_new as (
				select o.user_id, o.order_ts,  o.payment
				from orders o
				join orderstatuslog ol on ol.order_id = o.order_id
				join orderstatuses os on os.id = ol.status_id
				where os.key = 'Closed' and extract(year FROM o.order_ts) = 2022
			), last_order_date as (
				select distinct on (u.id) u.id as user_id, o.order_ts
				from users u
				left join orders_new o on u.id = o.user_id
				order by user_id, order_ts desc
			)
			select user_id, NTILE(5) OVER( ORDER BY order_ts ASC nulls First ) as recency
			from last_order_date
);


