-- 3. Напиши SQL-запрос
-- Имеем следующие таблицы:
--     1. users — контрагенты
--         1. id
--         2. name
--         3. phone
--         4. email
--         5. created — дата создания записи
--     2. orders — заказы
--         1. id
--         2. subtotal — сумма всех товарных позиций
--         3. created — дата и время поступления заказа (Y-m-d H:i:s)
--         4. city_id — город доставки
--         5. user_id
--
-- Необходимо выбрать одним запросом список контрагентов в следующем формате (следует учесть, что будет включена опция only_full_group_by в MySql):
--     1. Имя контрагента
--     2. Его телефон
--     3. Сумма всех его заказов
--     4. Его средний чек
--     5. Дата последнего заказа

SELECT
    u.name AS 'Имя контрагента',
        u.phone AS 'Его телефон',
        SUM(o.subtotal) AS 'Сумма всех его заказов',
        AVG(o.subtotal) AS 'Его средний чек',
        MAX(o.created) AS 'Дата последнего заказа'
FROM
    users u
        LEFT JOIN
    orders o ON u.id = o.user_id
GROUP BY
    u.id
ORDER BY
    u.name;


-- 4. Напиши SQL-запросы
-- Имеем следующую таблицу со списком сотрудников
-- Id
-- Name
-- LastName
-- DepartamentId
-- Salary
-- 1
-- Иван
-- Смирнов
-- 2
-- 100000
-- 2
-- Максим
-- Петров
-- 2
-- 90000
-- 3
-- Роман
-- Иванов
-- 3
-- 95000
-- …
--
--
--     1. Написать запрос для вывода самой большой зарплаты в каждом департаменте
--     2. Написать запрос для вывода списка сотрудников из 3-го департамента у которых ЗП больше 90000
--     3. Написать запрос по созданию индексов для ускорения

SELECT DepartamentId, MAX(Salary) AS MaxSalary
FROM Employees
GROUP BY DepartamentId;


SELECT *
FROM Employees
WHERE DepartamentId = 3 AND Salary > 90000;

CREATE INDEX idx_departament_id ON Employees(DepartamentId);
CREATE INDEX idx_salary ON Employees(Salary);
