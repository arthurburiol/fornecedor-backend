import ProdutosEstoqueBaixoView from '../models/ProdutosEstoqueBaixoView.js';

const listarEstoqueBaixo = async (req, res) => {
  try {
    const dados = await ProdutosEstoqueBaixoView.findAll();
    res.json(dados); // JSON com os produtos de estoque baixo
  } catch (error) {
    console.error('Erro ao buscar produtos com estoque baixo:', error);
    res.status(500).json({ erro: 'Erro ao buscar produtos com estoque baixo' });
  }
};

export default listarEstoqueBaixo;