import { useState, useEffect } from "react";
import { useNavigate, useParams } from "react-router-dom";
import axios from "axios";
import TituloCadastro from "../componentes/TituloCadastro";

export default function FormEstoque() {
  const navegacao = useNavigate();
  const { id } = useParams();

  const [produto_id, setProduto_id] = useState('');
  const [quantidade, setQuantidade] = useState('');
  const [produtos, setProdutos] = useState([]);

  // Buscar todos os produtos para o select
  const listarProdutos = async () => {
    const { data } = await axios.get("http://localhost:4000/produto");
    setProdutos(data);
  };

  // Se for edição (baixa de estoque)
  const selecionarEstoque = async () => {
    const { data } = await axios.get(`http://localhost:4000/estoque/${id}`);
    setProduto_id(data.produto_id);
    setQuantidade('');
  };

  // Entrada de novo estoque ou atualização
  const salvar = async () => {
  const produtoIdInt = parseInt(produto_id);
  const qtd = parseInt(quantidade);

  if (!produto_id || isNaN(qtd)) {
    alert("Selecione um produto e insira uma quantidade válida.");
    return;
  }

  try {
    let data = null;
        try {
        const response = await axios.get(`http://localhost:4000/estoque/produto/${produto_id}`);
        data = response.data;
        } catch (error) {
        if (error.response?.status !== 404) {
            alert("Erro ao buscar o estoque.");
            return;
        }
        }

        if (data) {
        // Produto já no estoque → soma a quantidade
        const novaQtd = parseInt(data.quantidade) + qtd;
        await axios.put(`http://localhost:4000/estoque/${data.id}`, {
            produto_id,
            quantidade: novaQtd,
        });
        } else {
        // Produto ainda não está no estoque → cria novo registro
        await axios.post(`http://localhost:4000/estoque`, {
            produto_id,
            quantidade: qtd,
        });
        }

        alert("Estoque atualizado com sucesso!");
        voltar();
    } catch (error) {
        console.error("Erro ao atualizar o estoque:", error.response?.data || error.message);
        alert("Erro ao atualizar o estoque.");

    }
};


  const voltar = () => {
    navegacao("/estoque");
  };

  useEffect(() => {
    listarProdutos();
    if (id) selecionarEstoque();
  }, [id]);

  return (
    <div className="container mt-4">
      <TituloCadastro id={id} titulo="Entrada de Estoque" />
      <div className="row mt-4">
        <div className="col-md-6">
          <form onSubmit={(e) => {
            e.preventDefault();
            salvar();
          }}>
            {id && (
              <div className="mb-3">
                <label className="form-label">Código</label>
                <input type="text" className="form-control" value={id} disabled />
              </div>
            )}

            <div className="mb-3">
              <label className="form-label">Produto</label>
              <select
                className="form-select"
                value={produto_id}
                onChange={(e) => setProduto_id(e.target.value)}
              >
                <option value="">Selecione um produto</option>
                {produtos.map((p) => (
                  <option key={p.id} value={p.id}>
                    {p.nome}
                  </option>
                ))}
              </select>
            </div>

            <div className="mb-3">
              <label className="form-label">Quantidade a adicionar</label>
              <input
                type="number"
                className="form-control"
                value={quantidade}
                onChange={(e) => setQuantidade(e.target.value)}
              />
            </div>

            <div className="d-flex gap-2 mb-5">
              <button type="submit" className="btn btn-primary">Salvar</button>
              <button type="button" className="btn btn-secondary" onClick={voltar}>
                Cancelar
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  );
}
