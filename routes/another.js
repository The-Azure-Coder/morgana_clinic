var express = require('express')
const conn = require('../lib/database')
var router = express.Router()


router.get('/',(req,res)=>{
    let sqlQuery = `SELECT * FROM departments`
    let sqlQuery2 = `SELECT * FROM procedures`
    conn.query(sqlQuery,(err,departRows)=>{
        if(err) throw err
        conn.query(sqlQuery2,(err,proRows)=>{
            if(err) throw err
            res.render('another',{
                department: departRows,
                procedure: proRows
            })
        })
    })
})

router.post('/add',(req,res)=>{
    let department_id = req.body.department_id
    let procedure_id = req.body.procedure_id

    let docQuery = `SELECT * from doctors where procedure_id =${procedure_id} AND department_id =${department_id}`
    conn.query(docQuery,(err,docRows)=>{
        if(err) throw err
        let appData = {
            patient_id:req.body.patient_id,
            doctor_id: docRows[0].id,
            department_id: req.body.department_id,
            procedure_id: req.body.procedure_id,
            current_date :new Date(Date.now()),
            appointment_date:new Date(Date.now() + 12096e5)
        }
       let bookAnother = 'INSERT INTO appointments SET ?'
       conn.query(bookAnother, appData,(err,appRows)=>{
           if(err) throw err
           res.redirect('/')
       })

    })
   
})

module.exports = router