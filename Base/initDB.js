const fs = require('fs')
const {Client} = require('pg')

const dbName = 'clinique_db'


// configuration de la base postgresql , ovaio my mdp an'la 

const defaultClient = new Client({
    user: 'postgres',
    host: 'localhost',
    database: 'postgres',
    password: 'postgresql', // ovaio my mdp an'la eto
    port: 5432,
});

const appClient = new Client({
    user: 'postgres',
    host: 'localhost',
    database: dbName,
    password: 'postgresql', // eto kou
    port: 5432,
});

async function createDataBaseIfNotExists(){
    await defaultClient.connect();
    const res = await defaultClient.query( 
        `SELECT 1 FROM pg_database WHERE datname = $1`, [dbName]
    )
    if (res.rowCount > 0){
        console.log(`La base de donnees "${dbName}" existe deja`)
    } else {
        await defaultClient.query(`CREATE DATABASE ${dbName}`)
        console.log(`Base de donnees "${dbName}" creee avec succes`)
    }
    await defaultClient.end()
}

async function runSQLScript() {
        const sql = fs.readFileSync('schema.sql').toString();
        await appClient.connect()
        await appClient.query(sql)
        console.log("Script executee avec succes !")
        await appClient.end()
    
}

(async () => {
    await createDataBaseIfNotExists()
    await runSQLScript()
})();
