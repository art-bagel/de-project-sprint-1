# Ход выполнения проекта

## 1. Построение витрины для RFM-анализа

### 1.1. Выявить требования к целевой витрине

 - Куда сложить витрину?
 - Витрина должна располагаться в той же базе в схеме analysis.
 
 - Какова структура витрины?
 - Витрина должна состоять из таких полей:
     user_id
     recency (число от 1 до 5)
     frequency (число от 1 до 5)
     monetary_value (число от 1 до 5)
     
 - Данные за какой период загружать в витрину?
 - В витрине нужны данные с начала 2022 года.
 
 - Как назвать витрину?
 - Назовите витрину dm_rfm_segments.
 
 - Как часто стоит обновлять витрину?
 - Обновления не нужны.
 
 - Что такое успешно выполненный заказ?
 - Это заказ со статусом Closed.

### 1.2. Изучить структуру исходных данных

Для расчета витрины понадобятся следующие поля:
 - Поле id из таблицы USERS - таким образом сможем получить всех пользователей,
   включая тех которые могли еще не совершить ни одного заказа.
   
 - Поле order_ts из таблицы ORDERS - для расчета последней даты успешного заказа
 
 - Поле payment из таблицы ORDERS - для расчета суммы и количества всех заказов
 
 - Поле status из таблицы ORDERS - для фильтрации успешных заказов.


### 1.3. Проанализировать качество данных

Проверялось качества данных в схеме production необходимых полей (id, order_ts, payment, status) для анализа:
Выбивающихся значений/пропусков/дубликатов и других проблем с данными не обнаружено. 

Замечания по полям не используемых в анализе:
 - Таблица USERS - перепутаны колонки запись имен идет в колонку логин и наоборот.
 - Для поддержания целостности данных нужно связать таблицу ORDERS с таблицей USERS
   через связь один ко многим где у одного пользователя может быть несколько заказов,
   добавить каскадное удаение.

Для улучшения качества данных в базе используются следующие инструменты:
таблица orders:
 - установленно правило NOT NULL в атрибутах
 - проводится проверка, при которой сумма платежа и бонуса не должны отличаться от стоимости
 - используется primary key для order_id, что исключает пустые значения и дубликаты заказа
таблица orderstatuses:
 - установленно правило NOT NULL в атрибутах


### 1.4. Подготовка витрины данных

 - По условию задачи были созданы представления в схеме 'analysis', которые отображают
   данные из схемы 'production'. В документе views.sql расположены скрипты создания представлений

 - Создана витрина dm_rfm_segments. Скрипт создания помещен в файл datamart_ddl.sql
 
 - По условию задачи созданы три таблицы по одной на каждый показатель, 
   расчитаны показатели и записаны в созданные таблицы. Созданы файлы 
   (tmp_rfm_recency.sql, tmp_rfm_frequency.sql, tmp_rfm_monetary_value.sql), 
   в которых содержатся скрипты заполнения таблиц с расчетами.
   
 - Из созданных таблиц, данные объеденены и записаны в витрину. Код скрипта располагается в
   файле datamart_query.sql


## 2. Доработка представлений

 Для выполнения условий второй задачи в файлы 
 (tmp_rfm_recency.sql, tmp_rfm_frequency.sql, tmp_rfm_monetary_value.sql) 
 добавлен код наполнения промежуточных таблиц с расчетами.
