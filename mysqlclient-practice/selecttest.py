from MySQLdb import connect, OperationalError
from MySQLdb.cursors import DictCursor

try:
    db = connect(
        user='webdb',
        password='webdb',
        host='localhost',
        port=3306,
        db='webdb',
        charset='utf8'
    )
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

    # 결과 보기
    for result in results:
        print(result)

except OperationalError as e:
    print(f"connect is failed. {e}")
