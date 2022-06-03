var express = require('express')
var router = express.Router()
var conn = require('../lib/database')

router.get('/',(req,res)=>{
    let sqlQuery = `SELECT * FROM departments`
    let sqlQuery2 = `SELECT * FROM procedures`
    conn.query(sqlQuery,(err,departRows)=>{
        if(err) throw err
        conn.query(sqlQuery2,(err,proRows)=>{
            if(err) throw err
            res.render('appointment',{
                department: departRows,
                procedure: proRows
            })
        })
    })
})

router.post('/book',(req,res)=>{
    let department_id = req.body.department_id
    let procedure_id = req.body.procedure_id

    let patientData = {
        first_nm : req.body.first_nm,
        last_nm : req.body.last_nm,
        gender: req.body.gender,  
        address: req.body.address,  
        phone_num: req.body.phone_num,
        email: req.body.email,
    }

    let patientQuery = `INSERT INTO patients SET ?;`

    conn.query(patientQuery,patientData,(err,patientRows)=>{
        if(err) throw err
        let docQuery = `SELECT * from doctors where procedure_id =${procedure_id} AND department_id =${department_id}`
        conn.query(docQuery,(err,docRows)=>{
            if(err) throw err
            console.log(patientRows)
            let appointData = {
                patient_id: patientRows.insertId,
                doctor_id: docRows[0].id,
                department_id: req.body.department_id,
                procedure_id: req.body.procedure_id,
                current_date :new Date(Date.now()),
               appointment_date:new Date(Date.now() + 12096e5)
            }

            let appointQuery = `INSERT INTO appointments SET ?`
            conn.query(appointQuery,appointData,(err,appointRows)=>{
                if(err) throw err
                res.redirect('/')
            })
        })
    })
})

module.exports = router