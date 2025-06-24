import TituloLista from "../componentes/TituloLista";
import axios from "axios";
import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";

export default function ListaFornecedor() {
  const [dados, setDados] = useState([]);
  const navigate = useNavigate();

  const listar = async () => {
    let { data } = await axios.get(`http://localhost:4000/fornecedor`);
    setDados(data);
  }

  useEffect(() => {
    listar();
  }, []);

  return (
    <>
      <TituloLista
        titulo="Fornecedores"
        descrição="Gerencie aqui os Fornecedores da Loja"
        rota="/cadastrofornecedor"
        botao="Novo Fornecedor"
      />

      <div className="container">
        <div className="row">
          <div className="col">
            <table className="table">
              <thead>
                <tr>
                  <th>Alterar</th>
                  <th>ID</th>
                  <th>CNPJ</th>
                  <th>Nome</th>
                  <th>E-mail</th>
                  <th>Endereço</th>
                  <th>Telefone</th>
                </tr>
              </thead>
              <tbody>
                {dados.map((fornecedor) => (
                  <tr key={fornecedor.id}>
                    <td>
                      <button
                        className="btn btn-dark"
                        onClick={() => navigate(`/cadastrofornecedor/${fornecedor.id}`)}
                      >
                        Alterar
                      </button>
                    </td>
                    <td>{fornecedor.id}</td>
                    <td>{fornecedor.cnpj}</td>
                    <td>{fornecedor.nome}</td>
                    <td>{fornecedor.email}</td>
                    <td>{fornecedor.endereco}</td>
                    <td>{fornecedor.telefone}</td>
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
