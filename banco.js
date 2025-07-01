import { Sequelize } from "sequelize";

//Conexão com o banco de dados
const sequelize = new Sequelize('sis_fornecedor', 'postgres', 'postgres', {
    host: 'localhost',
    port: 5432,
    dialect:'postgres',
    define: {
        timestamps: false,
        freezeTableName: true
    }
});

export default sequelize;