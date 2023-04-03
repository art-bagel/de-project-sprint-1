-- Код к задаче 1
insert into analysis.tmp_rfm_monetary_value (
	with orders_new as (
		select o.user_id, o.order_ts,  o.payment, os.key as status
		from orders o
		join orderstatuses os on o.status = os.id
		where os.key = 'Closed' extract(year FROM o.order_ts) = 2022
	)
	select u.id as user_id,  NTILE(5) OVER(ORDER by sum(payment) ASC nulls first) as monetary_value
	from users u
	left join orders_new o on u.id = o.user_id
	group by u.id
);

-- Код к задаче 2
insert into analysis.tmp_rfm_monetary_value (
			with orders_new as (
				select o.user_id, o.order_ts,  o.payment
				from orders o
				join orderstatuslog ol on ol.order_id = o.order_id
				join orderstatuses os on os.id = ol.status_id
				where os.key = 'Closed' and extract(year FROM o.order_ts) = 2022
			)
			select u.id as user_id,  NTILE(5) OVER(ORDER by sum(payment) ASC nulls first) as monetary_value
			from users u
			left join orders_new o on u.id = o.user_id
			group by u.id
);