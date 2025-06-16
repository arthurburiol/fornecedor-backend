import Produto from "../model/ProdutoModel.js";

// Listar todos os produtos
async function listar(req, res) {
    const respostaBanco = await Produto.findAll();
    res.json(respostaBanco);
}

// Selecionar um produto pelo ID
async function selecionar(req, res) {
    const id = req.params.id;
    const respostaBanco = await Produto.findByPk(id);
    res.json(respostaBanco);
}

// Inserir um novo produto
async function inserir(req, res) {
    const respostaBanco = await Produto.create(req.body);
    res.json(respostaBanco);
}

// Alterar um produto existente
async function alterar(req, res) {
    const id = req.params.id;

    const respostaBanco = await Produto.update(
        req.body,
        { where: { id } }
    );
    res.json(respostaBanco);
}

// Excluir um produto
async function excluir(req, res) {
    const id = req.params.id;

    const respostaBanco = await Produto.destroy({ where: { id } });
    res.json(respostaBanco);
}

export default { listar, selecionar, inserir, alterar, excluir };
