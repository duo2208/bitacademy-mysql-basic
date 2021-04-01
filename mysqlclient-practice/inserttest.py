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
    cursor = db.cursor()

    # SQL 실행
    sql = 'insert into emaillist values(null, "아", "무개", "amuge@naver.com")'
    count = cursor.execute(sql)

    # commit
    db.commit()

    # 자원 정리
    cursor.close()
    db.close()

    # 결과 보기
    print(f'실행 결과 : {count==1}')
    
except OperationalError as e:
    print(f"connect is failed. {e}")
