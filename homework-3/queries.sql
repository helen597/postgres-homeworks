-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
SELECT customers.company_name AS customer,
CONCAT(employees.first_name, ' ', employees.last_name) AS employee
FROM customers
INNER JOIN employees USING(city)
INNER JOIN orders USING(customer_id)
INNER JOIN shippers ON shipper_id=orders.ship_via
WHERE city='London'
AND shippers.company_name='United Package'
AND orders.employee_id=employees.employee_id

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
SELECT product_name, units_in_stock, suppliers.contact_name, suppliers.phone FROM products
INNER JOIN suppliers USING(supplier_id)
INNER JOIN categories USING(category_id)
WHERE products.discontinued=0
AND products.units_in_stock < 25
AND categories.category_name IN ('Dairy Products', 'Condiments')
ORDER BY products.units_in_stock

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
SELECT company_name FROM customers
WHERE company_name NOT IN
(SELECT company_name FROM customers
JOIN orders USING(customer_id))

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
-- 1 вариант
SELECT DISTINCT product_name FROM
(SELECT products.product_name FROM order_details
JOIN products USING(product_id)
WHERE order_details.quantity=10) AS foo;
-- 2 вариант
SELECT DISTINCT product_name FROM products
WHERE product_id IN (SELECT product_id FROM order_details WHERE quantity=10);