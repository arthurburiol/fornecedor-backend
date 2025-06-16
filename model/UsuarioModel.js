import { DataTypes } from "sequelize";
import banco from "../banco.js";

// Mapeamento da model Usuario
export default banco.define(
    'usuario',
    {
        id: {
            type: DataTypes.INTEGER,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        cpf: {
            type: DataTypes.STRING(14),
            allowNull: false,
            unique: true
        },
        nome: {
            type: DataTypes.STRING(60),
            allowNull: false
        },
        email: {
            type: DataTypes.STRING(100),
            allowNull: false,
            unique: true
        },
        senha: {
            type: DataTypes.STRING(255),
            allowNull: false
        },
        endereco: {
            type: DataTypes.TEXT,
            allowNull: false
        },
        telefone: {
            type: DataTypes.STRING(20),
            allowNull: true
        },
        data_cadastro: {
            type: DataTypes.DATE,
            allowNull: true,
            defaultValue: DataTypes.NOW
        }
    }
);
