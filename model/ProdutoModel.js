import { DataTypes } from "sequelize";
import banco from "../banco.js";

// Mapeamento da model Produto
export default banco.define(
    'produto',
    {
        id: {
            type: DataTypes.INTEGER,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        nome: {
            type: DataTypes.STRING(100),
            allowNull: false
        },
        descricao: {
            type: DataTypes.TEXT,
            allowNull: false
        },
        categoria: {
            type: DataTypes.STRING(50),
            allowNull: false
        },
        valor_unitario: {
            type: DataTypes.DECIMAL(10, 2),
            allowNull: false,
            validate: {
                min: 0.01
            }
        },
        fornecedor_id: {
            type: DataTypes.INTEGER,
            allowNull: false
        }
    }
);
