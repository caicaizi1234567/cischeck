import psycopg2
import os
from typing import List,Iterable
conn = psycopg2.connect(dbname="exampledb", user="dbuser", password="password", host="127.0.0.1", port="5432")
cur = conn.cursor()
cur.execute("drop table basemessage")
cur.execute("drop table password")
cur.execute('create table basemessage(id serial primary key,message varchar(200));')
cur.execute('create table password(id serial primary key,xiangmu varchar(200),content varchar(200),result varchar(200));')

fd = open("/basemessage/out.txt")
#fd1 = open("/home/cc/django/ubuntucheck/project_check/bassmessage/password.txt")

lines = fd.readlines()

for line in lines:
    print (line)
    cur.execute("insert into basemessage(message) values(%s)", (line,));

def read(fp: str, n: int) -> Iterable[List[str]]:
    i = 0
    num = 0
    lines = []
    with open(fp) as f:
        for line in f:
            i += 1
            num +=1
            lines.append(line.strip())
            if i == 1:
                a = line
            if i == 2:
                b = line
            if i == 3:
                c = line

            if i >= n:
                cur.execute("insert into password(xiangmu,content,result) values(%s,%s,%s)", (a,b,c,));
                yield lines

                i = 0
                lines.clear()

        if i > 0:
            yield lines


cur.execute("select * from basemessage")
rows = cur.fetchall()
for row in rows:
    print('id=' + str(row[0]) + ' message=' + str(row[1]))

if __name__ == '__main__':
    fp = '/basemessage/password.txt'
    lines_agen = read(fp, 3)
    for lines in lines_agen:
        print(lines)

fd.close()


conn.commit()
conn.close()
