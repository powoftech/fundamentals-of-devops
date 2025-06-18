const fs = require('fs').promises

console.log(process.env)

module.exports = {
  client: 'postgresql',

  connection: async () => {
    const rdsCaCert = await fs.readFile('rds-us-east-1-ca-cert.pem')

    return {
      database: process.env.DB_NAME,
      host: process.env.DB_HOST,
      port: process.env.DB_PORT,
      user: process.env.DB_USERNAME || process.env.TF_VAR_username,
      password: process.env.DB_PASSWORD || process.env.TF_VAR_password,
      ssl: { rejectUnauthorized: true, ca: rdsCaCert.toString() },
    }
  },

  debug: true,
}
