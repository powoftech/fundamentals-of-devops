const express = require('express')

const app = express()
app.set('view engine', 'ejs')

const backendHost = 'http://sample-app-backend-service:8080'

app.get('/', async (req, res) => {
  const response = await fetch(backendHost)
  const responseBody = await response.json()
  res.render('hello', { name: responseBody.text })
})

app.get('/name/:name', async (req, res) => {
  const response = await fetch(
    `${backendHost}/name/${encodeURIComponent(req.params.name)}`,
  )
  const responseBody = await response.json()
  res.render('hello', { name: responseBody.name })
})

module.exports = app
