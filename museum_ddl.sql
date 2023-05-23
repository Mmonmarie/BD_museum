create schema if not exists m;

set search_path=m;

create table if not exists museum_chain (
    chain_id serial not null primary key,
    name character varying (100) not null,
    owner varchar (100)
);

create table if not exists museum (
    museum_id serial not null primary key,
    chain_id integer not null references museum_chain(chain_id)
                                on delete restrict
                                on update restrict,
    address character varying (100) not null,
    working char not null
);

create table if not exists guide (
    guide_id serial not null primary key,
    name varchar (100) not null,
    worked_years integer,
    museum_id integer,
    constraint fk_museum foreign key (museum_id) references museum(museum_id)
);

create table if not exists exhibition (
    museum_id integer not null references museum(museum_id)
                                on delete restrict
                                on update restrict,
    exhibition_id serial not null primary key,
    name varchar (100) not null,
    from_date timestamp without time zone not null,
    to_date timestamp without time zone not null
);

create table if not exists excursion (
    exhibition_id integer not null references exhibition(exhibition_id),
    excursion_id serial not null primary key,
    guide_id integer not null references guide(guide_id),
    date timestamp without time zone not null,
    capacity integer,
    constraint fk_exhibition foreign key (exhibition_id) references exhibition(exhibition_id)
);
create table if not exists subscription (
    subscription_id serial not null primary key,
    price decimal (10, 2),
    valid_from timestamp without time zone not null,
    valid_to timestamp without time zone not null
);

create table if not exists visitor (
    visitor_id serial not null primary key,
    name varchar (100) not null,
    subscription_id integer references subscription(subscription_id)
                                   on delete cascade,
    age integer,
    gender char check (gender in ('f', 'm'))
);

create table if not exists visit (
    visitor_id integer not null references visitor(visitor_id)
                                on delete restrict
                                on update restrict,
    excursion_id integer not null references excursion(excursion_id)
                                on delete restrict
                                on update restrict
);