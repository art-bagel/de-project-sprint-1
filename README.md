# de-project-sprint-1
## **Описание проекта**


Вы выполняете задачу для компании, которая разрабатывает приложения по доставке еды. 

Вам предстоит составить витрину для RFM-классификации пользователей. 

**RFM** (англ. Recency Frequency Monetary* Value — давность, частота, деньги) — сегментация клиентов в анализе сбыта по лояльности.

Определяет три группы:

- **R**ecency (давность) — давность с момента последнего заказа.
- **F**requency (частота) — количество заказов.
- **M**onetary Value (деньги) — сумма затрат клиента.

### **Задача 1**

Вы должны каждому клиенту присвоить сегмент - число от 1 до 5 - по каждому из трех измерений. При этом границы необходимо подобрать таким образом, чтобы количество коиентов в каждом сегменте было одинаковым.

Например, если в базе всего 100 клиентов, то 20 клиентов должны получить “1”, 20 клиентов должны получить “2” и т.д.

Для Frequency и Monetary Value клиенты располагаются по возрастанию. Т.е. клиенты с наименьшим количеством заказов получат “1” по шкале frequency. Аналогично, клиенты с наименьшей суммой трат получат “1” по шкале monetary value.

Шкала recency меряется по последнему заказу клиента. “1” получат те, кто не делал заказов а так же те, кто делал заказы давно. “5” получат клиенты, делавшие заказы позже остальных, т.е. относительно недавно.

### **Задача 2**

К вам в ужасе прибегает менеджер и сообщает, что витрина больше не собирается. Вы начинаете разбираться, в чем причина и выясняете, что разработчики бэкенда приложения обновили структуру данных в схеме production. Очень торопились выкатить релиз и в суматохе забыли предупредить вас об этом.

Разберемся, что именно было изменено. В таблице Orders больше нет поля статус. А это поле вам очень нужно, т.к. для задач аналитики вы берете только успешно выполненные заказы (завершенные статусом closed). Вместо поля с одним статусом разработчики добавили таблицу для журналирования всех изменений статусов заказов - `production.OrderStatusLog`.

Структура таблицы: 

- id - синтетический автогенерируемый идентификатор записи.
- order_id - идентификатор заказа, внешний слюч на таблицу `production.Orders`.
- status_id - идентификатор статуса, внешний ключ на таблицу статусов заказов - `production.OrderStatuses`.
- dttm - таймстемп, дата и время получения заказом этого статуса.

Для того, чтобы ваш скрипт по расчету витрины продолжил работать, вам необходимо внести изменения в то, как формируется представление (view) `analysis.Orders` - вам необходимо cделать так, чтобы в этом представлении по-прежнему присутствовало поле `status`. Значение в этом поле должно соответствовать последнему (по времени) значению статуса из таблицы `production.OrderStatusLog`.
