var express = require('express')
const conn = require('../lib/database')
var router = express.Router()


router.get('/',(req,res)=>{
    conn.query(`SELECT * FROM departments`,(err,rows)=>{
        res.render('departments',{
            departments: rows
        })

    })
})

router.get('/sort/:id',(req,res)=>{
    let departQuery = `SELECT pt.procedure FROM procedures pt where department_id = ${req.params.id}`
    conn.query(departQuery,(err,rows)=>{
        if(err) throw err
        res.render('departments',{
            departments: rows
        })
        console.log(rows)
    })
})

module.exports = router