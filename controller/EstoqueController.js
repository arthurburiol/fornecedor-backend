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
    console.log(inserir);
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

// 22-06
// Buscar item de estoque pelo produto_id
async function buscarPorProduto(req, res) {
    const produto_id = req.params.produto_id;

    try {
        const item = await Estoque.findOne({ where: { produto_id } });

        if (item) {
            res.json(item);
        } else {
            res.status(404).json(null); // produto ainda não está no estoque
        }
    } catch (error) {
        console.error("Erro ao buscar produto no estoque:", error);
        res.status(500).json({ error: "Erro interno ao buscar produto no estoque" });
    }
}

async function baixarEstoque(req, res) {
  const produto_id = req.params.produto_id;
  const quantidadeBaixa = parseInt(req.body.quantidade);

  try {
    const itemEstoque = await Estoque.findOne({ where: { produto_id } });

    if (!itemEstoque) {
      return res.status(404).json({ mensagem: "Produto não encontrado no estoque." });
    }

    if (itemEstoque.quantidade < quantidadeBaixa) {
      return res.status(400).json({ mensagem: "Estoque insuficiente para essa baixa." });
    }

    const novaQuantidade = itemEstoque.quantidade - quantidadeBaixa;

    await Estoque.update(
      { quantidade: novaQuantidade },
      { where: { produto_id } }
    );

    res.json({ mensagem: "Baixa realizada com sucesso.", novaQuantidade });
  } catch (error) {
    console.error("Erro ao baixar estoque:", error);
    res.status(500).json({ erro: "Erro ao baixar estoque." });
  }
}
//FIM

export default { listar, selecionar, inserir, alterar, excluir, buscarPorProduto, baixarEstoque };
