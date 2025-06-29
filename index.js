import cors from "cors";
import express from "express";
import banco from "./banco.js";
import fornecedor from "./controller/FornecedorController.js";
import estoque from "./controller/EstoqueController.js";
import produto from "./controller/ProdutoController.js";
import usuario from "./controller/UsuarioController.js";
import api from "./controller/ApiController.js"

try {
    await banco.authenticate();
    console.log('Conexão com o banco de dados realizada com sucesso.');
} catch (error) {
    console.error('Erro ao conectar com o banco de dados:', error);
}

const app = express();
app.use(express.json());

app.use(cors());

app.get('/teste', (req, res) => {
    res.send('Teste ok.');
});

//rotas crud da tabela Estoque
app.get('/estoque', estoque.listar);
//22-06
app.get('/estoque/produto/:produto_id', estoque.buscarPorProduto);
app.put('/estoque/baixa/:produto_id', estoque.baixarEstoque);
//FIM
app.get('/estoque/:id', estoque.selecionar);
app.post('/estoque', usuario.validarToken, estoque.inserir);
app.put('/estoque/:id', usuario.validarToken, estoque.alterar);
app.delete('/estoque/:id', usuario.validarToken, estoque.excluir);


//rotas crud da tabela Produto
app.get('/produto', produto.listar);
app.get('/produto/:id', produto.selecionar);
app.post('/produto',  produto.inserir);
app.put('/produto/:id', produto.alterar);
app.delete('/produto/:id', produto.excluir);


//rotas crud da tabela Usuario
app.get('/usuario', usuario.listar);
app.get('/usuario/:id', usuario.selecionar);
app.post('/usuario', usuario.inserir);
app.put('/usuario/:id', usuario.alterar);
app.delete('/usuario/:id', usuario.excluir);
app.put('/loginusuario', usuario.login);
app.put('/senhausuario/:id', usuario.definirsenha)

//rotas crud da tabela Fornecedor
app.get('/fornecedor', fornecedor.listar);
app.get('/fornecedor/:id', usuario.validarToken, fornecedor.selecionar);
app.post('/fornecedor', usuario.validarToken, fornecedor.inserir);
app.put('/fornecedor/:id', usuario.validarToken, fornecedor.alterar);
app.delete('/fornecedor/:id', usuario.validarToken, fornecedor.excluir);

app.get('/solicitarfrete', api.solicitarFrete);
app.get('/solicitardespacho', api.solicitarDespacho);

app.listen(4000, () => { console.log(`Servidor rodando.`) });


