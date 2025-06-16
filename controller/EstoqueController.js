import Estoque from "../model/EstoqueModel.js";

// Listar todos os registros de estoque
async function listar(req, res) {
    const respostaBanco = await Estoque.findAll();
    res.json(respostaBanco);
}

// Selecionar um registro de estoque pelo ID
async function selecionar(req, res) {
    const id = req.params.id;
    const respostaBanco = await Estoque.findByPk(id);
    res.json(respostaBanco);
}

// Inserir um novo registro de estoque
async function inserir(req, res) {
    const respostaBanco = await Estoque.create(req.body);
    res.json(respostaBanco);
}

// Alterar um registro de estoque existente
async function alterar(req, res) {
    const id = req.params.id;

    const respostaBanco = await Estoque.update(
        req.body,
        { where: { id } }
    );
    res.json(respostaBanco);
}

// Excluir um registro de estoque
async function excluir(req, res) {
    const id = req.params.id;

    const respostaBanco = await Estoque.destroy({ where: { id } });
    res.json(respostaBanco);
}

export default { listar, selecionar, inserir, alterar, excluir };
