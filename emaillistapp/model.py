from MySQLdb import connect, OperationalError
from MySQLdb.cursors import DictCursor

def findAll():
    try:
        db = conn()

        # cursor 객체 생성 : 
        cursor = db.cursor(DictCursor)

        # SQL 실행
        sql = 'select no, first_name, last_name, email from emaillist order by no desc'
        cursor.execute(sql)

        # 결과 받아오기
        results = cursor.fetchall()

        # 자원 정리
        cursor.close()
        db.close()

        # 결과 반환
        return results

    except OperationalError as e:
        print(f"connect is failed. {e}")


def insert(first_name, last_name, email):
    try:
        db = conn()

        # cursor 객체 생성 : 
        cursor = db.cursor()

        # SQL 실행
        sql = 'insert into emaillist values(null, %s, %s, %s)'
        count = cursor.execute(sql, (first_name, last_name, email))

        # commit
        db.commit()

        # 자원 정리
        cursor.close()
        db.close()

        return count == 1

    except OperationalError as e:
        print(f"connect is failed. {e}")

def removebyemail(email):
    try:
        db = conn()

        # cursor 객체 생성 :
        cursor = db.cursor()

        # SQL 실행
        sql = 'delete from emaillist where email = %s'
        cursor.execute(sql, [email])

        # commit
        db.commit()

        # 자원 정리
        cursor.close()
        db.close()

    except OperationalError as e:
        print(f"connect is failed. {e}")


def conn():
    return connect(
        user='webdb',
        password='webdb',
        host='localhost',
        port=3306,
        db='webdb',
        charset='utf8'
    )