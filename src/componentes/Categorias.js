import { useEffect, useState } from "react";
import axios from "axios";
import TituloLista from "./TituloLista";

export default function Estoque() {
  const [produtos, setProdutos] = useState([]);
  const [fornecedores, setFornecedores] = useState([]);
  const [estoque, setEstoque] = useState([]);

  useEffect(() => {
    listarProdutos();
    listarFornecedores();
    listarEstoque(); 
  }, []);

  const listarProdutos = async () => {
    const { data } = await axios.get("http://localhost:4000/produto");
    setProdutos(data);
  };

  const listarFornecedores = async () => {
    const { data } = await axios.get("http://localhost:4000/fornecedor");
    setFornecedores(data);
  };

  const listarEstoque = async () => {
    const { data } = await axios.get("http://localhost:4000/estoque");
    setEstoque(data);
  };

  const nomeProduto = (produto_id) => {
    const produto = produtos.find((p) => p.id === produto_id);
    return produto ? produto.nome : "Produto não encontrado";
  };

  const valorProduto = (produto_id) => {
    const produto = produtos.find((p) => p.id === produto_id);
    return produto ? `R$ ${produto.valor_unitario}` : "—";
  };

  const nomeFornecedor = (produto_id) => {
    const produto = produtos.find((p) => p.id === produto_id);
    if (!produto) return "—";
    const fornecedor = fornecedores.find((f) => f.id === produto.fornecedor_id);
    return fornecedor ? fornecedor.nome : "Fornecedor não encontrado";
  };

  return (
    <>
      <TituloLista
        titulo="Estoque"
        descrição="Gerenciamento de Estoque"
        rota="/gerenciaestoque"
        botao="Entrada de Estoque"
      />

      <div className="container">
        <div className="row">
          <div className="col">
            <table className="table">
              <thead>
                <tr>
                  <th>Alterar</th>
                  <th>Produto</th>
                  <th>Valor</th>
                  <th>Fornecedor</th>
                  <th>Quantidade</th>
                </tr>
              </thead>
              <tbody>
                {estoque.map((item) => {
                  const produto = produtos.find((p) => p.id === item.produto_id);
                  return (
                    <tr key={item.id}>
                      <td>
                        <a className="btn btn-danger" href={`/baixaestoque/${produto.id}`}>
                          Baixa Estoque
                        </a>
                      </td>
                      <td>{nomeProduto(item.produto_id)}</td>
                      <td>{valorProduto(item.produto_id)}</td>
                      <td>{nomeFornecedor(item.produto_id)}</td>
                      <td>{item.quantidade}</td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </>
  );
}