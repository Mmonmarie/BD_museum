-- выбрать всех посетителей, которым не больше 40 лет, упорядочить по возрасту
select *
from visitor
where age <= 41
order by age;

-- выбрать все музеи, где были экскурсии за 2021 год
select name
from exhibition
join museum on museum.museum_id = exhibition.museum_id
join excursion on exhibition.exhibition_id = excursion.exhibition_id
where extract(year from date) = '2021';

-- вывести имена всех посетителей с абонементов
select name
from visitor
where subscription_id is not null;

-- вывести id всех абонементов стоимостью не меньше 5 тысяч и имена их владельцев
select visitor.subscription_id, name
from visitor
join subscription on visitor.subscription_id = subscription.subscription_id
where price >= 5000;

-- обновить возраст посетителя Ксении
update visitor
    set age = 40
where name = 'Ксения';

-- вывести новый возраст Ксении
select name, age
from visitor
where name = 'Ксения';

-- вывести все экскурсии Ксении
select name, excursion.excursion_id
from excursion
join visit on excursion.excursion_id = visit.excursion_id
join visitor v on visit.visitor_id = v.visitor_id
where name = 'Ксения';

-- вывести все экскурсии, которые проходят в 2023 году
select *
from excursion
where extract(year from date) = '2023';

-- добавить Ксении все экскурсии 2023 года
insert into visit (visitor_id, excursion_id) values
    (2, 3),
    (2, 4),
    (2, 5);

-- вывести имена всех владельцев сети музеев, если они есть, иначе 'нет'
select
    case
        when owner is null then 'нет'
        else owner
    end as owner
from museum_chain;

-- вывести все рабочие музеи и экскурсоводов, работающих в них
select museum.museum_id, address, guide.name
from museum
left join guide on museum.museum_id = guide.museum_id
where working = 'y'





