-- DDL создание витрины dm_rfm_segments
create table if not exists dm_rfm_segments(
    user_id int primary key,
    recency smallint not NULL,
    frequency smallint not null,
    monetary_value smallint not null,
    CONSTRAINT recency_check CHECK (recency >= 1 and recency <= 5 ),
    CONSTRAINT frequency_check CHECK (frequency >= 1 and frequency <= 5 ),
    CONSTRAINT monetary_value_check CHECK (monetary_value >= 1 and monetary_value <= 5 )
)