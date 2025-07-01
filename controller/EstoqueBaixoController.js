import ProdutosEstoqueBaixoView from "../model/EstoqueBaixoModel.js";

const listarEstoqueBaixo = async (req, res) => {
  try {
    const dados = await ProdutosEstoqueBaixoView.findAll();
    res.json(dados);
  } catch (error) {
    console.error('Erro ao buscar produtos com estoque baixo:', error);
    res.status(500).json({ erro: 'Erro ao buscar produtos com estoque baixo' });
  }
};

export default listarEstoqueBaixo;