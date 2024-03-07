import mysql.connector
from mysql.connector import errorcode

try:
    apConnection = mysql.connector.connect(
        user='root', password='password',
        host='localhost',
        database='ap'
    )

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print('Invalid credentials')
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print('Database not found')
    else:
        print('Cannot connect to database:', err)

else:
    invoiceCursor = apConnection.cursor()

    # invoiceData = (95, 0.00, 0.00, 0.00, 0)
    #
    # result = invoiceCursor.callproc('test', invoiceData)
    # print(result[1], result[2], result[3], result[4])
    # invoiceCursor.close()

    mycursor = apConnection.cursor()

    # vendorInitial = "I"
    vendorInitial = "N%' OR 1=1 -- "    # SQL Injection Examples

    sqlString = "SELECT * FROM vendors WHERE vendor_name LIKE '" + vendorInitial + "%'"
    print(sqlString)

    mycursor.execute(sqlString)

    myresult = mycursor.fetchall()

    for x in myresult:
        print(x)

    apConnection.close()