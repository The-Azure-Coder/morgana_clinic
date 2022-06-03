const { query } = require('express')
var express = require('express')
var router = express.Router()
var conn = require('../lib/database')

router.get('/',(req,res)=>{
    if(req.session.loggedin == true){
 let sqlQuery = `SELECT 
  at.id AS app_id,
  pt.first_nm,
  pt.last_nm,
  pt.gender,
  pt.email,
  pt.id AS pat_id,
  dt.id as doc_id,
  dt.title,
  dt.first_nm AS Doc_fname,
  dt.last_nm As Doc_lname,
  pr.procedure,
  pr.estimated_cost,
  dp.department,
  at.current_date,
  at.appointment_date

FROM
   morgana.patients pt,
   morgana.doctors dt,
   morgana.procedures pr,
   morgana.departments dp,
   morgana.appointments at
   
WHERE
   pt.id = at.patient_id
AND
   dt.id = at.doctor_id
AND
   pr.id = at.procedure_id
AND
   dp.id = at.department_id
`

let sqlQuery2 = `SELECT count(pt.procedure) AS procedure_num,  avg(pt.estimated_cost) AS average_cost from morgana.procedures pt`
conn.query(sqlQuery,(err,allrows)=>{
    if(err) throw err
    conn.query(sqlQuery2,(err,agrows)=>{
        if(err) throw err
        res.render('dashboard',{
            appointments: allrows,
            aggregate: agrows
        })
    })
})

    }else{
        res.redirect('/login')
    }
})

router.get('/edit/:app_id',(req,res)=>{
   let app_id = req.params.app_id
  let sqlQuery = `SELECT 
   pt.first_nm,
   pt.last_nm,
   pt.address,
   pt.email,
   pt.phone_num,
   pt.gender,
   dt.title,
   dt.first_nm AS Doc_fname,
   dt.last_nm As Doc_lname,
   pr.procedure,
   dp.department,
   dp.id AS depart_id,
   dt.id AS doc_id,
   pr.id AS pro_id,
   pt.id AS pat_id,
   at.id AS app_id,
   at.current_date,
   at.appointment_date
   
 FROM
    morgana.patients pt,
    morgana.doctors dt,
    morgana.procedures pr,
    morgana.departments dp,
    morgana.appointments at
    
 WHERE
    pt.id = at.patient_id
 AND
    dt.id = at.doctor_id
 AND
    pr.id = at.procedure_id
 AND
    dp.id = at.department_id
 AND
    at.id = ${app_id}
 `
 let sqlQuery2 = `SELECT * FROM departments`
 let sqlQuery3 = `SELECT * FROM procedures`

 conn.query(sqlQuery,(err,allrows)=>{
     if(err) throw err
 conn.query(sqlQuery2,(err,departrows)=>{
    if(err) throw err
    conn.query(sqlQuery3,(err,prorows)=>{
        if(err) throw err
        res.render('appointment-edit',{
            procedure: prorows,
            department: departrows,
            appointment: allrows[0]
        })
    })
 })

 })
})

router.post('/update',(req,res)=>{
    let patientSql = `update patients SET first_nm='${req.body.first_nm}',  last_nm='${req.body.last_nm}',  gender='${req.body.gender}',  address=' ${req.body.address}', phone_num='${req.body.phone_num}', email='${req.body.email}' where id =${req.body.patient_id}`

    conn.query(patientSql,(err,patRows)=>{
        if(err) throw err
        let appointSql = `update appointments SET patient_id='${req.body.patient_id}',  doctor_id='${req.body.doctor_id}',  department_id='${req.body.department_id}',  procedure_id='${req.body.procedure_id}', department_id='${req.body.department_id}' where id =${req.body.app_id}`
        conn.query(appointSql,(err,appRows)=>{
            if(err) throw err
            res.redirect('/dashboard')
        })

    })

})

router.get('/delete/:pat_id',(req,res)=>{
    let deleteQuery1 = `DELETE FROM patients WHERE id =${req.params.pat_id}`
    conn.query(deleteQuery1,(err,deleteRows)=>{
        if(err) throw err
            res.redirect('/dashboard')
        })
    })

module.exports = router