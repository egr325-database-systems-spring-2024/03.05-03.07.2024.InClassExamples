import mysql.connector
from mysql.connector import errorcode

class DBConnection:
    def __init__(self, connection):
        self.connection = connection

    # BAD - do NOT do this
    def authenticate(self, username: str, password: str) -> bool:
        with self.connection.cursor(buffered=True) as cursor:
            # Use a Parameterized Query
            adminQuery = ("""SELECT * FROM users WHERE username = %s AND password = %s""")
            cursor.execute(adminQuery, (username, password))

            # adminQuery = ("""SELECT * FROM users WHERE username = %(username)s AND password = %(password)s""")
            # cursor.execute(adminQuery,{'username':username,'password':password})

            result = cursor.fetchone()

        if result is None:
            # User and Password combination does not match any existing record
            return False;

        return True

    def close(self):
        self.connection.close()

try:
    apConnection = mysql.connector.connect(
        user='root', password='password',
        host='localhost',
        database='ap'
    )

    ap = DBConnection(apConnection)

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print('Invalid credentials')
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print('Database not found')
    else:
        print('Cannot connect to database:', err)

else:

    user = 'haki'
    password = 'password1'
    print("Authenticate " + user + "/" + password + " returns " + str(ap.authenticate(user, password)))

    user = 'ran'
    password = 'password2'
    print("Authenticate " + user + "/" + password + " returns " + str(ap.authenticate(user, password)))

    user = 'joe'
    password = 'password3'
    print("Authenticate " + user + "/" + password + " returns " + str(ap.authenticate(user, password)))

    user = 'sam'
    password = 'password4'
    print("Authenticate " + user + "/" + password + " returns " + str(ap.authenticate(user, password)))

    user = 'admin'
    password = 'password5'
    print("Authenticate " + user + "/" + password + " returns " + str(ap.authenticate(user, password)))

    user = 'foo'    # non-existent user
    password = 'password'
    print("Authenticate " + user + "/" + password + " returns " + str(ap.authenticate(user, password)))

    user = 'admin'    # user with incorrect password
    password = 'password'
    print("Authenticate " + user + "/" + password + " returns " + str(ap.authenticate(user, password)))

    user = 'x'    # sql injection attack
    password = "x' OR '1'='1' -- "
    print("Authenticate " + user + "/" + password + " returns " + str(ap.authenticate(user, password)))

    ap.close()

