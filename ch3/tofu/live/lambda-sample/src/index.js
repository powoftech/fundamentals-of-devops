exports.handler = (event, context, callback) => {
  callback(null, {
    statusCode: 200,
    body: { message: 'Fundamentals of DevOps!' },
  })
}
