import { useState, useEffect } from "react";
import { useNavigate, useParams } from "react-router-dom";
import axios from "axios";
import TituloCadastro from "../componentes/TituloCadastro";

export default function FormFornecedor() {
  const navegacao = useNavigate();
  const { id } = useParams();

  const [cnpj, setCnpj] = useState('');
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
    const { data } = await axios.get(`http://localhost:4000/fornecedor/${id}`);
    setCnpj(data.cnpj || '');
    setNome(data.nome || '');
    setEmail(data.email || '');
    setEndereco(data.endereco || '');
    setTelefone(data.telefone || '');
  };

  const alterar = async () => {
    await axios.put(`http://localhost:4000/fornecedor/${id}`, {
      cnpj,
      nome,
      email,
      endereco,
      telefone
    });
    navegacao('/listafornecedor');
  };

  const inserir = async () => {
    await axios.post(`http://localhost:4000/fornecedor`, {
      cnpj,
      nome,
      email,
      endereco,
      telefone
    });
    navegacao('/listafornecedor');
  };

  const salvar = async () => {
    if (id) {
      await alterar();
    } else {
      await inserir();
    }
  };

  const excluir = async () => {
    await axios.delete(`http://localhost:4000/fornecedor/${id}`);
    navegacao('/listafornecedor');
  };

  return (
    <div className="container mt-4">
      <TituloCadastro id={id} titulo="Fornecedor" />
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
              <label className="form-label">CNPJ</label>
              <input
                type="text"
                className="form-control"
                value={cnpj}
                onChange={(e) => setCnpj(e.target.value)}
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
              <button type="button" className="btn btn-secondary" onClick={() => navegacao('/listafornecedor')}>
                Cancelar
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  );
}

