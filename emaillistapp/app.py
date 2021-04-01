import sys
import os

try:
    sys.path.append(os.getcwd())
    # sys.path.append('C:/Users/izimi/OneDrive/바탕 화면/수업자료/(비트교육) 융복합 AI 응용서비스 개발 실무/01_Python Web & DB/vscode/mysql-practice')
except ImportError:
    raise ImportError("Import Fail")

from MySQLdb import connect, OperationalError
from emaillistapp import model

def run_list():
    results = model.findAll()

    # 결과 보기
    for index, result in enumerate(results):
        print(f'{index+1}:{result["first_name"]}{result["last_name"]}:{result["email"]}')

def run_add():
    first_name = input('first name : ')
    last_name = input('last name : ')
    email = input('email : ')

    model.insert(first_name, last_name, email)

    run_list()

def run_delete():
    email = input('email : ')

    model.removebyemail(email)

    run_list()

def main():
    while True:
        cmd = input(f'(l)ist, (a)add, (d)elete (q)uit > ')

        if cmd == 'q':
            break
        elif cmd == 'l':
            run_list()
        elif cmd == 'a':
            run_add()
        elif cmd == 'd':
            run_delete()
        else:
            print("uncorrect menu")

        print(f'execute {cmd}')

if __name__ == '__main__' :
    main()