-- триггер на добавление или удаление экскурсий в таблице экскурсий
create table if not exists logs_excursion (
    excursion text,
    time timestamp without time zone
);

create or replace function add_del_excursion() returns trigger as
$$
    declare
        id integer;
        text varchar(50);
    begin
        if tg_op = 'INSERT' then
            id := new.excursion_id;
            text := 'excursion is added';
            insert into logs_excursion values (concat (id, ' ', text), now());
            return new;
        elsif tg_op = 'DELETE' then
            id := old.excursion_id;
            text := 'excursion is deleted';
            insert into logs_excursion values (concat (id, ' ', text), now());
            return old;
        end if;
    end
$$ language plpgsql;

insert into excursion values (2, 8, 4,'2023-03-03', null);
delete from excursion where excursion_id = 8;

create or replace trigger t_excursion
after insert or delete on excursion for each row
execute procedure add_del_excursion();

select * from logs_excursion;

-- если выставка продлевается, то пишем новую дату окончания

create or replace function elongation() returns trigger as
$$
    declare
        id_m integer;
        name_e varchar(100);
        from_date_e timestamp without time zone;
    begin
            id_m := old.museum_id;
            name_e := old.name;
            from_date_e := old.from_date;
            insert into exhibition(museum_id, name, from_date, to_date) values (id_m, name_e, from_date_e, new.to_date);
            return new;
    end
$$ language plpgsql;

create  or replace trigger t_elongation
after update on exhibition for each row
execute function elongation();

update exhibition set to_date = '2030-09-22' where name = '19-ый век';

drop function elongation() cascade;

select * from exhibition;

-- при изменении сроков действия (с какого времени, по какое время) абонемента пишутся новые сроки

create or replace function new_subscription() returns trigger as
$$
    declare
        price_old decimal (10,2);
    begin
        price_old := old.price;
        insert into subscription(price, valid_from, valid_to) values (price_old, new.valid_from, new.valid_to);
        return new;
    end;
$$ language plpgsql;

create or replace trigger t_subscription
after update on subscription for each row
execute function new_subscription();

update subscription set valid_to = '2023-04-30' where price = 9999.99;
select * from subscription;