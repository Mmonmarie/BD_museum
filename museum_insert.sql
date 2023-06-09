set search_path = m;
insert into museum_chain (name, owner) values
('Средневековье', 'Багров Андрей'),
('Империя', null),
('Смута', 'Рассветов Дмитрий'),
('СССР', null),
('Романовы', 'Романов Алексей'),
('Современность', null),
('Правители', 'Цветаева Марина'),
('Культура XVIII века', 'Ефремова Светлана');

insert into museum (chain_id, address, working) values
(1,'Москва, улица Арбатская', 'y'),
(2, 'Москва, улица Тверская', 'y'),
(3, 'Санкт-Петербург, проспект Невский', 'n'),
(4, 'Екатеринбург, улица Московская', 't'),
(5, 'Тверь, переулок Смоленский', 'n'),
(6, 'Москва, улица Окружная', 'n'),
(7, 'Нижний Новгород, улица Алексеевская', 'y'),
(8, 'Москва, площадь Революции', 'y'),
(8, 'Долгопрудный, улица Первомайская', 'n'),
(1,'Москва, улица Чеховская', 'n'),
(2,'Москва, площадь Смоленская', 'y');

insert into guide (name, worked_years, museum_id) values
('Петр', 32, 10),
('Дмитрий', 5, 1),
('Виктория', 20, 2),
('Анастасия', null, 3),
('Лидия', 2, 4),
('Максим', 18, 5),
('Владимир', null, 6),
('Ксения', 11, 7),
('Алексей', 23, 8),
('Надежда', 16, 9);

insert into exhibition (museum_id, name, from_date, to_date) values
(1, '19-ый век', '2021-09-20', '2023-09-20'),
(3, 'Исторические личности', '2018-03-03', '2025-03-03'),
(4, 'Жизнь Романовых', '2023-06-13', '2023-07-13'),
(2, 'Лжеправители', '2022-02-22', '2024-04-24'),
(8, 'Серебряный век', '2022-01-02', '2024-01-02');

insert into subscription (price, valid_from, valid_to) values
(9999.99, '2020-10-10', '2021-10-10'),
(39999.90, '2021-10-10', '2024-02-10'),
(1999.0, '2023-04-10', '2023-05-10'),
(3500.0, '2023-01-09', '2023-07-09'),
(12059.9, '2022-11-11', '2023-11-11'),
(50000.0, '2022-06-01', '2025-06-01' ),
(4999.99, '2023-02-20', '2023-12-20');

insert into excursion (exhibition_id, guide_id, date, capacity) values
(1, 2,'2022-02-01', 30),
(3, 6,'2023-07-01', 25),
(5, 9, '2023-01-02', 10),
(4, 3, '2023-02-22', null),
(2, 4, '2021-03-03', 50);

insert into visitor (name, age, gender, subscription_id) values
('Галина', 37, 'f', 1),
('Ксения', 34, 'f', null),
('Владимир', 70, 'm', 2),
('Елизавета', 18, 'f', 3),
('Петр', null, 'm', 4),
('Катерина', 22, 'f', 7),
('Олег', 37, 'm', 6),
('Борис', 38, 'm', 5),
('Наталья', 37, 'f', null),
('Леонид', 45, 'm', null);

insert into visit (visitor_id, excursion_id) values
(1, 1),
(2, 2),
(3, 1),
(2, 1),
(4, 1),
(10, 1),
(10, 2),
(7, 2),
(8, 1);


