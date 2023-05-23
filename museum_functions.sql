-- вывести самую посещаемую экскурсию
create function top_excursions() returns integer as $$
declare
    top integer;
    begin
        with t as (
            select count(*) over (partition by excursion_id) as visits, excursion_id
            from visit
        ),
            t1 as (
            select dense_rank() over (order by visits desc) as rank, visits, t.excursion_id as excursion_id
            from t
            left join excursion e on e.excursion_id = t.excursion_id
            group by 3, 2
            order by 1
            )
        select excursion_id into top
        from t1
        limit 1;
        return top;
    end;
$$ language plpgsql;

-- вывести самый посещаемый музей
create function top_museums() returns integer as $$
declare
    top integer;
    begin
        with t as (
            select m.museum_id as museum_id, e.exhibition_id as exhibition_id, e2.excursion_id as excursion_id
            from museum m
            join exhibition e on m.museum_id = e.museum_id
            join excursion e2 on e.exhibition_id = e2.exhibition_id
        ),
            t1 as (
            select count(*) over (partition by excursion_id) as visits, excursion_id
            from visit
        ),
            t2 as (
            select t.excursion_id, t.exhibition_id, t.museum_id as museum_id, t1.visits as visits
            from t
            join t1 on t.excursion_id = t1.excursion_id
        ),
            t3 as (
            select dense_rank() over (order by visits desc) as rank, visits, museum_id
            from t2
            group by 3, 2
            order by 1
        )
        select museum_id into top
        from t3
        limit 1;
        return top;
    end;
$$ language plpgsql;
