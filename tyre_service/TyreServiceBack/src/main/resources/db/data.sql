INSERT INTO PARTNERS(id, name, description, address, email, phone, schedule, rank, latitude, longitude, type) VALUES
    (1, 'Рога и копыта', 'Занимаемся подрезкой копыт и шлифовкой рогов', 'Адрес 1',
    'rog@gmail.com', '8-910-234-56-78','08:00 - 22:00', 3.9, 10.0, 0.0, 'PASSENGER'),
    (2, 'Хвост и усы', 'Занимаемся закручиванием усов и стрижкой хвостов', 'Адрес 2',
        'hvost@gmail.com', '8-911-234-56-78','08:00 - 22:00', 3.5, 12.0, 0.0, 'PASSENGER'),
    (3, 'Копыта и рога', 'Занимаемся подрезкой копыт и шлифовкой рогов', 'Адрес 3',
        'kopita@gmail.com', '8-910-234-56-78','08:00 - 22:00', 3.5, 0.0, 10.0, 'OFFROAD'),
    (4, 'Усы и хвост', 'Занимаемся закручиванием усов и стрижкой хвостов', 'Адрес 4',
        'usi@gmail.com', '8-911-234-56-78','08:00 - 22:00', 3.0, 0.0, 9.0, 'OFFROAD'),
    (5, 'Айболит', 'Занимаемся подрезкой копыт и шлифовкой рогов', 'Адрес 3',
        'kopita@gmail.com', '8-910-234-56-78','08:00 - 22:00', 3.5, 10.0, 0.0, 'PASSENGER')
;

INSERT INTO CLIENTS(id, name, phone, email) VALUES
    (1, 'Client1', '8978548961', 'fsdff;fjff;fsf;sfs')
;

--Пароль для всех партнеров 12345
INSERT INTO USERS(id, login, password, role, account) VALUES
    (1, 'Partner1', '{bcrypt}$2a$10$O/NH7f05JJhN7wpldZa3.OHRDfbgX7aRMxpN1DHfxbywF4BKrN.H6', 'PARTNER', 1),
    (2, 'Partner2', '{bcrypt}$2a$10$O/NH7f05JJhN7wpldZa3.OHRDfbgX7aRMxpN1DHfxbywF4BKrN.H6', 'PARTNER', 2),
    (3, 'Partner3', '{bcrypt}$2a$10$O/NH7f05JJhN7wpldZa3.OHRDfbgX7aRMxpN1DHfxbywF4BKrN.H6', 'PARTNER', 3),
    (4, 'Partner4', '{bcrypt}$2a$10$O/NH7f05JJhN7wpldZa3.OHRDfbgX7aRMxpN1DHfxbywF4BKrN.H6', 'PARTNER', 4),
    (5, 'Partner5', '{bcrypt}$2a$10$O/NH7f05JJhN7wpldZa3.OHRDfbgX7aRMxpN1DHfxbywF4BKrN.H6', 'PARTNER', 5),
    (6, 'Client1', '{bcrypt}$2a$10$O/NH7f05JJhN7wpldZa3.OHRDfbgX7aRMxpN1DHfxbywF4BKrN.H6', 'CLIENT', 1)
;

INSERT INTO WORKS(id, name) VALUES
    (1, 'Первая услуга'),
    (2, 'Вторая услуга'),
    (3, 'Третья услуга'),
    (4, 'Четвертая услуга')
;

INSERT INTO COSTS_WORKS(partner_id, work_id, price) VALUES
    (1, 1, 100),
    (1, 2, 50),
    (1, 3, 110),
    (1, 4, 50),
    (2, 1, 95),
    (2, 2, 50),
    (2, 3, 50),
    (3, 1, 105),
    (3, 2, 105),
    (3, 4, 45),
    (4, 2, 45),
    (4, 3, 45),
    (4, 4, 45)
;

INSERT INTO ORDERS(id, partner_id, create_date, booking_date, status, client_name, client_phone, client_auto) VALUES
    (1, 1, '2020-10-01', '2020-10-02','WAITING', 'Иван', '892815748596145', 'VW Polo'),
    (2, 1, '2020-10-11', '2020-10-15','WAITING', 'Иван', '892815748596145', 'VW Polo'),
    (3, 2, '2020-10-13', '2020-10-20','WAITING', 'Сергей', '892815748596145', 'Sloda Rapid')
;

INSERT INTO LINES_ORDER(order_id, work_id, price, count) VALUES
    (1, 1, 100, 4),
    (1, 2, 50, 4),
    (2, 2, 500, 1),
    (3, 2, 150, 4),
    (3, 3, 120, 4)
;