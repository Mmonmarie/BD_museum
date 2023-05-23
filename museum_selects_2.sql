-- вывести сумму абонементов для групп, где людям больше 30 и меньше 30
select price, case
                    when age < 30 then 'young'
                    else 'not young' end as age_group
from subscription
join visitor v on v.subscription_id = subscription.subscription_id
group by v.age, 1;

-- вывести для каждой из одной группы общую стоимость всех абонементов в группе
with t as (
    select price, case
                    when age < 30 then 'young'
                    else 'not young' end as age_group
    from subscription
    join visitor v on v.subscription_id = subscription.subscription_id
    group by v.age, 1
    order by 2 desc
)
select sum(t.price), age_group
from t
group by t.age_group;

-- вывести все выставки, которые открылись раньше 2022
select name
from exhibition
group by name
having min(extract(year from from_date)) < 2022;

-- отранжировать посетителей по числу визитов и вывести общую сумму посещений каждого
with t as (
    select count(*) over (partition by visitor_id) as visits, visitor_id
    from visit
)
select dense_rank() over (order by visits desc) as rank, visits, name
from t
left join visitor v on v.visitor_id=t.visitor_id
group by 3, 2
order by 1;

-- вывести адресса неработающих музея по алфавиту
with t as (
    select *
    from museum
    where working = 'n'
    )
select address
from t
group by working, address
order by 1;

-- вывести абонемент, который купили самым первым
with t as (
    select dense_rank() over (order by valid_from), subscription_id, price
    from subscription
    group by subscription_id
)
select subscription_id, price
from t
limit 1;

-- для каждой экскурсии вывести предыдущую и следующую относительно нее
select excursion_id, date,
       lag(date) over (order by extract(year from date)) as previous_excursion,
       lead(date) over (order by extract(year from date)) as next_excursion
from excursion


