import { DataTypes } from "sequelize";
import banco from "../banco.js";

// Mapeamento da model Fornecedor
export default banco.define(
    'fornecedor',
    {
        id: {
            type: DataTypes.INTEGER,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        cnpj: {
            type: DataTypes.STRING(18),
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
