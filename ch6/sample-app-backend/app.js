const express = require('express')

const app = express()
app.set('view engine', 'ejs')

app.get('/', (req, res) => {
  res.json({ text: 'backend microservice' })
})

app.get('/name/:name', (req, res) => {
  res.json({ name: req.params.name })
})

module.exports = app
