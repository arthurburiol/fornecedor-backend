import { DataTypes } from "sequelize";
import banco from "../banco.js";

// Mapeamento da model Estoque
export default banco.define(
  'estoque',
  {
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true,
    },
    produto_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    quantidade: {
      type: DataTypes.INTEGER,
      allowNull: false,
      validate: {
        min: 0,
      },
    },
    data_atualizacao: {
      type: DataTypes.DATE,
      allowNull: true,
      defaultValue: DataTypes.NOW,
    },
  },
  {
    tableName: 'estoque',
    timestamps: false,
  }
);