"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2, csv

conn = psycopg2.connect(host='localhost',
                        database='north',
                        user='postgres',
                        password='123')

cur = conn.cursor()

with conn:
    with conn.cursor() as cur:
        with open('north_data/customers_data.csv', 'r') as customers_data:
            next(customers_data)
            csvreader = csv.reader(customers_data)
            for row in csvreader:
                cur.execute("INSERT INTO customers VALUES (%s, %s, %s)", (row[0], row[1], row[2]))
        with open('north_data/employees_data.csv', 'r') as employees_data:
            next(employees_data)
            csvreader = csv.reader(employees_data)
            for row in csvreader:
                cur.execute("INSERT INTO employees VALUES (%s, %s, %s, %s, %s, %s)",
                            (row[0], row[1], row[2], row[3], row[4], row[5]))
        with open('north_data/orders_data.csv', 'r') as orders_data:
            next(orders_data)
            csvreader = csv.reader(orders_data)
            for row in csvreader:
                cur.execute("INSERT INTO orders VALUES (%s, %s, %s, %s, %s)",
                            (row[0], row[1], row[2], row[3], row[4]))
