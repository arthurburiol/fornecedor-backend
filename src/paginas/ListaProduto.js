import TituloLista from "../componentes/TituloLista";
import axios from "axios";
import { useState, useEffect } from "react";
import FormFornecedor from "./FormFornecedor";

export default function ListaProduto() {
  const [dados, setDados] = useState([]);
  const [fornecedores, setFornecedores] = useState([]);

  const listarProdutos = async () => {
    const { data } = await axios.get(`http://localhost:4000/produto`);
    setDados(data);
  };

  const listarFornecedores = async () => {
    const { data } = await axios.get("http://localhost:4000/fornecedor");
    setFornecedores(data);
  };

  useEffect(() => {
    listarProdutos();
    listarFornecedores();
  }, []);

  return (
    <>
      <TituloLista
        titulo="Produtos"
        descrição="Gerencie aqui os Produtos da loja"
        rota="/cadastroproduto"
        botao="Novo Produto"
      />

      <div className="container">
        <div className="row">
          <div className="col">
            <table className="table">
              <thead>
                <tr>
                  <th scope="col">Alterar</th>
                  <th scope="col">Nome</th>
                  <th scope="col">Descrição</th>
                  <th scope="col">Categoria</th>
                  <th scope="col">Valor</th>
                  <th scope="col">Fornecedor</th>
                </tr>
              </thead>
              <tbody>
                {dados.map((d) => (
                  <tr key={d.id}>
                    <td>
                      <a className="btn btn-dark" href={`/cadastroproduto/${d.id}`}>
                        Alterar
                      </a>
                    </td>
                    <td>{d.nome}</td>
                    <td>{d.descricao}</td>
                    <td>{d.categoria}</td>
                    <td>{d.valor_unitario}</td>
                    <td>{d.fornecedor_id}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </>
  );
}
