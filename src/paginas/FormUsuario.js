import { useState, useEffect } from "react";
import { useNavigate, useParams } from "react-router-dom";
import axios from "axios";
import TituloCadastro from "../componentes/TituloCadastro";

export default function FormUsuario() {
  const navegacao = useNavigate();
  const { id } = useParams();

  const [cpf, setCpf] = useState('');
  const [nome, setNome] = useState('');
  const [email, setEmail] = useState('');
  const [endereco, setEndereco] = useState('');
  const [telefone, setTelefone] = useState('');

  useEffect(() => {
    if (id) {
      selecionar();
    }
  }, [id]);

  const selecionar = async () => {
    const { data } = await axios.get(`http://localhost:4000/usuario/${id}`);
    setCpf(data.cpf || '');
    setNome(data.nome || '');
    setEmail(data.email || '');
    setEndereco(data.endereco || '');
    setTelefone(data.telefone || '');
  };

  const alterar = async () => {
    await axios.put(`http://localhost:4000/usuario/${id}`, {
      cpf,
      nome,
      email,
      endereco,
      telefone
    });
    navegacao('/listausuario');
  };

  const inserir = async () => {
    await axios.post(`http://localhost:4000/usuario`, {
      cpf,
      nome,
      email,
      endereco,
      telefone
    });
    navegacao('/listausuario');
  };

  const salvar = async () => {
    if (id) {
      await alterar();
    } else {
      await inserir();
    }
  };

  const excluir = async () => {
    await axios.delete(`http://localhost:4000/usuario/${id}`);
    navegacao('/listausuario');
  };

  return (
    <div className="container mt-4">
      <TituloCadastro id={id} titulo="Usuario" />
      <div className="row mt-4">
        <div className="col-md-6">
          <form onSubmit={(e) => {
            e.preventDefault();
            salvar();
          }}>
            {id && (
              <div className="mb-3">
                <label className="form-label">Código</label>
                <input
                  type="text"
                  className="form-control"
                  value={id}
                  disabled
                />
              </div>
            )}

            <div className="mb-3">
              <label className="form-label">CPF</label>
              <input
                type="text"
                className="form-control"
                value={cpf}
                onChange={(e) => setCpf(e.target.value)}
              />
            </div>

            <div className="mb-3">
              <label className="form-label">Nome</label>
              <input
                type="text"
                className="form-control"
                value={nome}
                onChange={(e) => setNome(e.target.value)}
              />
            </div>

            <div className="mb-3">
              <label className="form-label">E-mail</label>
              <input
                type="email"
                className="form-control"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
              />
            </div>

            <div className="mb-3">
              <label className="form-label">Endereço</label>
              <input
                type="text"
                className="form-control"
                value={endereco}
                onChange={(e) => setEndereco(e.target.value)}
              />
            </div>

            <div className="mb-3">
              <label className="form-label">Telefone</label>
              <input
                type="text"
                className="form-control"
                value={telefone}
                onChange={(e) => setTelefone(e.target.value)}
              />
            </div>

            <div className="d-flex gap-2 mb-5">
              <button type="submit" className="btn btn-primary">
                Salvar
              </button>
              {id && (
                <button type="button" className="btn btn-danger" onClick={excluir}>
                  Excluir
                </button>
              )}
              <button type="button" className="btn btn-secondary" onClick={() => navegacao('/listausuario')}>
                Cancelar
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  );
}

