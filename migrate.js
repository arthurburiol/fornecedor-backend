import sequelize from './banco.js';
import './model/EstoqueModel.js';
import './model/FornecedorModel.js';
import './model/ProdutoModel.js';
import './model/UsuarioModel.js';

await sequelize.sync({ alter: true })
    .then(result => console.log(
        "Tabelas criadas com sucesso"))
    .catch(error => console.log(
        "Erro ao criar tabelas", error));
