import Usuario from "../model/UsuarioModel.js";

// Listar todos os usuários
async function listar(req, res) {
    const respostaBanco = await Usuario.findAll();
    res.json(respostaBanco);
}

// Selecionar um usuário pelo ID
async function selecionar(req, res) {
    const id = req.params.id;
    const respostaBanco = await Usuario.findByPk(id);
    res.json(respostaBanco);
}

// Inserir um novo usuário
async function inserir(req, res) {
    const respostaBanco = await Usuario.create(req.body);
    res.json(respostaBanco);
}

// Alterar um usuário existente
async function alterar(req, res) {
    const id = req.params.id;

    const respostaBanco = await Usuario.update(
        req.body,
        { where: { id } }
    );
    res.json(respostaBanco);
}

// Excluir um usuário
async function excluir(req, res) {
    const id = req.params.id;

    const respostaBanco = await Usuario.destroy({ where: { id } });
    res.json(respostaBanco);
}

export default { listar, selecionar, inserir, alterar, excluir };
