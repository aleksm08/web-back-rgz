import pymysql
from flask import Flask, flash, render_template, request, redirect, url_for
from flask_login import LoginManager, login_user, login_required
from werkzeug.security import generate_password_hash, check_password_hash


app = Flask(__name__)
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0
app.secret_key = 'super secret key'

login_manager = LoginManager(app)

global username

try:
    connection = pymysql.connect(
        host="localhost",
        user="root",
        password="Z1klon766",
        database="recipes",
        cursorclass=pymysql.cursors.DictCursor
    )
    username = ""
    print("Подключение удалось")

except Exception as ex:
    print("Ошибка подключения...")
    print(ex)

class UserLogin():
    def from_db(self, user_id, db):
        with connection.cursor() as cursor:
            str = "SELECT * FROM users WHERE (id='{0}') LIMIT 1".format(user_id)
            cursor.execute(str)
            res = cursor.fetchone()
            if(not res):
                flash("Пользователь не найден", "error")
                return False

        self.__user = res
        return  self

    def create(self, user):
        self.__user = user
        return self

    def is_authenticated(self):
        return True

    def is_active(self):
        return True

    def is_anonymos(self):
        return False

    def get_id(self):
        return str(self.__user['id'])

@login_manager.user_loader
def load_user(user_id):
    return UserLogin().from_db(user_id, connection)

#рецепты без фильтров
@app.route('/')
def main():
    with connection.cursor() as cursor:
        select_all_rows = "SELECT * FROM main"
        cursor.execute(select_all_rows)
        rows = cursor.fetchall()
        for row in rows:
            print(row)
        print("#" * 20)
    return render_template('main.html', nods=rows, name=username)

#рецепты по фильтрам
@app.route('/<string:type>/<string:country>/')
def filter(type, country):
    with connection.cursor() as cursor:
        if country=='1':
            select_type_rows = "SELECT * FROM main WHERE (type='{0}')".format(type)
        elif type=='1':
            select_type_rows = "SELECT * FROM main WHERE (country='{0}')".format(country)
        else:
            select_type_rows = "SELECT * FROM main WHERE (type='{0}') AND (country='{1}')".format(type, country)
        cursor.execute(select_type_rows)
        rows = cursor.fetchall()
        for row in rows:
            print(row)
        print("#" * 20)
    return render_template('main.html', nods=rows, name=username)

#поиск
@app.route('/<string:name>', methods=['POST'])
def search(name):
    name = request.form['name']
    with connection.cursor() as cursor:
        select_type_rows = "SELECT * FROM main WHERE (name='{0}')".format(name)
        cursor.execute(select_type_rows)
        rows = cursor.fetchall()
        for row in rows:
            print(row)
        print("поиск" * 20)
        return render_template('main.html', nods=rows, name=username)


#добавление рецепты
@app.route('/add', methods=['POST'])
@login_required
def add():
    with connection.cursor() as cursor:
        str = "SELECT * FROM users WHERE (username='{0}')".format(username)
        cursor.execute(str)
        uname = cursor.fetchone()

        add_row = "INSERT INTO main (name, type, country, ingredients, cooking, user_id) VALUES ('%s', '%s', '%s', '%s', '%s', '%s')"%(
            request.form['name'], request.form['type'], request.form['country'], request.form['ingredients'], request.form['cooking'], uname.get('id'))
        cursor.execute(add_row)
        connection.commit()

        select_all_rows = "SELECT * FROM main"
        cursor.execute(select_all_rows)
        rows = cursor.fetchall()
        return render_template('main.html', nods=rows, name=username)

#регистрация
@app.route('/registr')
def registr():
    return render_template('reg.html')

@app.route('/reg', methods=['POST'])
def reg():
    if(request.method == "POST"):
        with connection.cursor() as cursor:
            check = "SELECT * FROM users WHERE (username='{0}')".format(request.form['name'])
            cursor.execute(check)
            res = cursor.fetchall()
            if(len(res) > 0):
                flash("Имя занято", "error")
                return render_template('reg.html')

        hash = generate_password_hash(request.form['psw'])
        try:
            with connection.cursor() as cursor:
                add_user = "INSERT INTO users (username, email, password) VALUES ('%s', '%s', '%s')" % (
                    request.form['name'], request.form['email'], hash)
                cursor.execute(add_user)
                connection.commit()
                flash("Успешная регистрация", "success")
        except:
            flash("Ошибка регистрации. Попробуйте позже", "error")
            return render_template('reg.html')

        with connection.cursor() as cursor:
            select_all_rows = "SELECT * FROM main"
            cursor.execute(select_all_rows)
            rows = cursor.fetchall()
        return render_template('main.html', nods=rows, name=username)

@app.route('/login', methods=['POST'])
def login():
    if request.method == 'POST':
        with connection.cursor() as cursor:
            str = "SELECT * FROM users WHERE (username='{0}') LIMIT 1".format(request.form['uname'])
            cursor.execute(str)
            user = cursor.fetchone()
            if (not user):
                flash("Пользователь не найден", "error")
                return render_template('main.html')
        if user and check_password_hash(user['password'], request.form['psw']):
            userLogin = UserLogin().create(user)
            login_user(userLogin)
            flash("Успешный вход", "success")
            global username
            username = request.form['uname']
            with connection.cursor() as cursor:
                select_all_rows = "SELECT * FROM main"
                cursor.execute(select_all_rows)
                rows = cursor.fetchall()
            return render_template('main.html', nods=rows, name=username)
        flash("Неверное имя или пароль", "error")
        return render_template('main.html')