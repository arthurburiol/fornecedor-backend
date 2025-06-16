import Fornecedor from "../model/FornecedorModel.js";

// Listar todos os fornecedores
async function listar(req, res) {
    const respostaBanco = await Fornecedor.findAll();
    res.json(respostaBanco);
}

// Selecionar um fornecedor pelo ID
async function selecionar(req, res) {
    const id = req.params.id;
    const respostaBanco = await Fornecedor.findByPk(id);
    res.json(respostaBanco);
}

// Inserir um novo fornecedor
async function inserir(req, res) {
    const respostaBanco = await Fornecedor.create(req.body);
    res.json(respostaBanco);
}

// Alterar um fornecedor existente
async function alterar(req, res) {
    const id = req.params.id;

    const respostaBanco = await Fornecedor.update(
        req.body,
        { where: { id } }
    );
    res.json(respostaBanco);
}

// Excluir um fornecedor
async function excluir(req, res) {
    const id = req.params.id;

    const respostaBanco = await Fornecedor.destroy({ where: { id } });
    res.json(respostaBanco);
}

export default { listar, selecionar, inserir, alterar, excluir };
;