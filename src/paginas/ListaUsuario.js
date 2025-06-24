import TituloLista from "../componentes/TituloLista";
import axios from "axios";
import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";

export default function ListaUsuario() {
  const [dados, setDados] = useState([]);
  const navigate = useNavigate();

  const listar = async () => {
    let { data } = await axios.get(`http://localhost:4000/usuario`);
    setDados(data);
  }

  useEffect(() => {
    listar();
  }, []);

  return (
    <>
      <TituloLista
        titulo="Usuarios"
        descrição="Gerenciamento de Usuarios do Sistema"
        rota="/cadastrousuario"
        botao="Novo Usuario"
      />

      <div className="container">
        <div className="row">
          <div className="col">
            <table className="table">
              <thead>
                <tr>
                  <th>Alterar</th>
                  <th>ID</th>
                  <th>CPF</th>
                  <th>Nome</th>
                  <th>E-mail</th>
                  <th>Endereço</th>
                  <th>Telefone</th>
                </tr>
              </thead>
              <tbody>
                {dados.map((usuario) => (
                  <tr key={usuario.id}>
                    <td>
                      <button
                        className="btn btn-dark"
                        onClick={() => navigate(`/cadastrousuario/${usuario.id}`)}
                      >
                        Alterar
                      </button>
                    </td>
                    <td>{usuario.id}</td>
                    <td>{usuario.cpf}</td>
                    <td>{usuario.nome}</td>
                    <td>{usuario.email}</td>
                    <td>{usuario.endereco}</td>
                    <td>{usuario.telefone}</td>
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
