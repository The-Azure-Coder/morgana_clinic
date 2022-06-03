var mysql = require('mysql')
var conn = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'Root',
    database: 'morgana',
    dateStrings: true

})

conn.connect((err) => {
    if (!err)
        console.log('connect to database successfully')

    else
        console.log('Connection failed' + JSON.stringify(err, undefined, 2))

})

module.exports = conn