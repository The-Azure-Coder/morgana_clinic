var express = require('express')
const conn = require('../lib/database')
var router = express.Router()

router.get('/',(req,res)=>{
    res.render('login',{

    })
})

router.post('/auth',(req,res)=>{
    var email = req.body.email
    var password = req.body.password
    let authQuery = ` SELECT * FROM morgana.users WHERE email = ? AND BINARY password = ?`

conn.query( authQuery,[email,password],(err,rows)=>{
    if(err) throw err

    if (rows.length <= 0) {
        req.session.loggedin = false
        console.log(req.session);
        res.redirect('/login')
    }else{
        req.session.loggedin = true;
        req.session.user_id = rows[0].id;
        req.session.first_nm = rows[0].first_nm;
        req.session.last_nm = rows[0].last_nm;
        req.session.user_type= rows[0].user_type;
        console.log(req.session);
        res.redirect('/dashboard');
    }
})

})

router.get('/logout', function (req, res) {
    req.session.destroy();
    res.redirect('/login');
});
module.exports = router