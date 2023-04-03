--Код создания представлений на основе таблиц из схемы production
create view analysis.orderitems as (select * from production.orderitems );
create view analysis.orders as (select * from production.orders);
create view analysis.orderstatuslog as (select * from production.orderstatuslog);
create view analysis.products as (select * from production.products);
create view analysis.users as (select * from production.users);