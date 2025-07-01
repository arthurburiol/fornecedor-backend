import { DataTypes } from 'sequelize';
import sequelize from '../banco.js';

const ProdutosEstoqueBaixoView = sequelize.define('ProdutosEstoqueBaixoView', {
  produto_id: {
    type: DataTypes.INTEGER,
    primaryKey: true
  },
  nome_produto: {
    type: DataTypes.STRING(100)
  },
  nome_fornecedor: {
    type: DataTypes.STRING(60)
  },
  estoque_atual: {
    type: DataTypes.BIGINT
  }
}, {
  tableName: 'produtos_estoque_baixo',
  timestamps: false
});

export default ProdutosEstoqueBaixoView;