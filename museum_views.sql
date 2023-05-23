-- таблица с именами посетителями и датами их экскурсий и общее кол-во посетителей на каждую экскурсию
create or replace view visit_excursion as
    select count(*) over (partition by date) as number_of_visitors, name, date
    from visitor
    join visit on visitor.visitor_id = visit.visitor_id
    join excursion e on visit.excursion_id = e.excursion_id
    group by 2, 3
    order by 3, 2;

select * from visit_excursion;

-- таблица c гидами, адресами музеев, где они работают и их экскурсиями
create or replace view museum_inf as
    select guide.name, date, address
    from guide
    left join museum m on guide.museum_id = m.museum_id
    left join excursion e on guide.guide_id = e.guide_id
    order by 1, 2;

select * from museum_inf;

-- таблица с названиями выставок, датами экскурсий в них и адреса музеев
create or replace view exhibition_inf as
    select exhibition.name, date, address
    from exhibition
    left join excursion e on exhibition.exhibition_id = e.exhibition_id
    left join museum m on exhibition.museum_id = m.museum_id
    order by 2;

select * from exhibition_inf;

-- таблица с общим числом посещений каждого музея за все время
create or replace view museum_visit as
    with t as (
        select count(*) over (partition by date) as number_of_visitors, name, date, e.excursion_id as exs_id
        from visitor
        join visit on visitor.visitor_id = visit.visitor_id
        join excursion e on visit.excursion_id = e.excursion_id
        group by 2, 3, 4
        order by 3, 2
    )
    select distinct number_of_visitors, address
    from t
    join excursion e on t.exs_id = e.excursion_id
    join exhibition e2 on e.exhibition_id = e2.exhibition_id
    join museum m on e2.museum_id = m.museum_id
    order by 2;

select * from museum_visit;

-- вывести таблицу со стоимостью абонементов и первыми двумя буквами имени

create or replace view mask_sub as
    select price, concat(substring(name, 1, 2), '', 'xxx') as name
    from visitor
    left join subscription s on visitor.subscription_id = s.subscription_id;

select * from mask_sub;

-- вывести только город работы для каждого экскурсовода, проранжировать по городу (скрываем полный адресс)
create or replace view guide_town as
    select dense_rank() over (order by split_part(address, ',', 1)) as rank, split_part(address, ',', 1), name
    from museum
    join guide g on museum.museum_id = g.museum_id
    order by 2, 3;

select * from guide_town;


