var express = require('express')
const layout = require('express-ejs-layouts')
var app = express()
var path = require('path')
var cookieParser = require('cookie-parser');
const session = require('express-session');
const flash = require('express-flash')


app.use(layout)
app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(express.static('public'))
app.use('/images', express.static('images'))

app.use(flash())
app.use(cookieParser());
app.use(session({
    secret: 'secREt$#code$%3245',
    resave: false,
    saveUninitialized: true,
    cookie: { maxAge: 1200000 }
}))

app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, 'views'))
app.set('layout', 'layouts/layout')




var homeRouter = require('./routes/home')
var appointRouter = require('./routes/appoint')
var loginRouter = require('./routes/login')
var dashRouter = require('./routes/dashboard')

app.use('/',homeRouter)
app.use('/appoint',appointRouter)
app.use('/login',loginRouter)
app.use('/dashboard',dashRouter)


const port = process.env.PORT || 5000
app.listen(port, () => {
    console.log(`listening to http://localhost:${port}`)

})


