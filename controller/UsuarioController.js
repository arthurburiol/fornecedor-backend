import Usuario from "../model/UsuarioModel.js";
import bcrypt from 'bcrypt';
import { v4 as uuidv4 } from 'uuid';

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
    const nome = req.body.nome;
    const cpf = req.body.cpf;
    const email = req.body.email;
    const endereco = req.body.endereco;
    const telefone = req.body.telefone;

    const bodyInserir = {
        cpf,
        nome,
        email,
        endereco,
        telefone
    };

    const inserirUsuario = await Usuario.create(bodyInserir);

    res.json(inserirUsuario)
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

async function login(req, res) {
    const email = req.body.email;
    const senha = req.body.senha;

    if (!email || !senha) {
        res.status(422).send('Os parâmetros email e senha são obrigatórios.');
        return;
    }

    const usuarioFornecedor = await Usuario.findOne({ where: { email } });
    if (!usuarioFornecedor) {
        res.status(404).send('E-mail ou senha inválida.(e-mail)');
        return;
    }

    const senhavalida = await bcrypt.compare(senha, usuarioFornecedor.senha);
    if (!senhavalida) {
        res.status(404).send('E-mail ou senha inválida.');
        return;
    }

    const token = uuidv4(); // não precisa de await aqui
    const id = usuarioFornecedor.id;

    await Usuario.update(
        {
            token
        },
        { where: { id } }
    );


    res.status(200).send(token);
}

async function definirsenha(req, res) {
    //Lendo os parametros
    const idusuario = req.params.id;
    const senhaBody = req.body.senha;

    //verifica se existe o paramentro idfuncionario
    if (!idusuario) {
        res.status(422).send('O parâmetro idusuario é obrigatório.');
        return;
    }

    //verifica se o funcionário existe
    const usuarioFornecedor = await Usuario.findByPk(idusuario);
    if (!usuarioFornecedor) {
        res.status(404).send('Usuário não encontrado.');
        return;
    }

    if (senhaBody.length < 6 || senhaBody.length > 20) {
        res.status(422).send('Tamanho da senha deve ser de 6 a 20 caracteres');
        return;
    }

    const senha = await bcrypt.hash(senhaBody, 10);
    const token = "TOKEN";
    const id = idusuario;

    await Usuario.update(
        {
            senha,
            token
        },
        { where: { id } }
    );

    res.status(200).send('Senha do Usuário alterada com sucesso.');
}

async function validarToken(req, res, next) {
    //Lendo os parametros
    const token = req.headers.token;

    //verifica se existe o paramentro senha e email
    if (!token) {
        res.status(422).send('Token é obrigatório.');
        return;
    }

    //verifica se o funcionário existe
    const usuarioFornecedor = await usuarioFornecedor.findOne({ where: { token } });
    if (!usuarioFornecedor) {
        res.status(404).send('Token inválido.');
        return;
    }

    next();
}

export default { listar, selecionar, inserir, alterar, excluir, login, validarToken, definirsenha };
