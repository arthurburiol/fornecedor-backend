import { useState, useEffect } from "react";
import { useNavigate, useParams } from "react-router-dom";
import axios from "axios";
import TituloCadastro from "../componentes/TituloCadastro";

export default function FormProduto() {
  const navegacao = useNavigate();
  const { id } = useParams();

  const [nome, setNome] = useState('');
  const [descricao, setDescricao] = useState('');
  const [categoria, setCategoria] = useState('');
  const [valor_unitario, setValor_unitario] = useState('');
  const [fornecedor_id, setFornecedor_id] = useState('');

  const selecionar = async () => {
    const { data } = await axios.get(`http://localhost:4000/produto/${id}`);
    setNome(data.nome);
    setDescricao(data.descricao);
    setCategoria(data.categoria);
    setValor_unitario(data.valor_unitario);
    setFornecedor_id(data.fornecedor_id);
  };

  const alterar = async () => {
    const body = {
      nome,
      descricao,
      categoria,
      valor_unitario,
      fornecedor_id
    };
    await axios.put(`http://localhost:4000/produto/${id}`, body);
    voltar();
  };

  const inserir = async () => {
    const body = {
      nome,
      descricao,
      categoria,
      valor_unitario,
      fornecedor_id
    };
    await axios.post(`http://localhost:4000/produto/`, body);
    voltar();
  };

  const salvar = async () => {
    if (id) {
      await alterar();
    } else {
      await inserir();
    }
  };

  const excluir = async () => {
    await axios.delete(`http://localhost:4000/produto/${id}`);
    voltar();
  };

  const voltar = () => {
    navegacao('/listaproduto');
  };

  useEffect(() => {
    if (id) {
      selecionar();
    }
  }, [id]);

  return (
    <div className="container mt-4">
      <TituloCadastro id={id} titulo="Produto" />
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
              <label className="form-label">Nome</label>
              <input
                type="text"
                className="form-control"
                value={nome}
                onChange={(e) => setNome(e.target.value)}
              />
            </div>

            <div className="mb-3">
              <label className="form-label">Descrição</label>
              <input
                type="text"
                className="form-control"
                value={descricao}
                onChange={(e) => setDescricao(e.target.value)}
              />
            </div>

            <div className="mb-3">
              <label className="form-label">Categoria</label>
              <input
                type="text"
                className="form-control"
                value={categoria}
                onChange={(e) => setCategoria(e.target.value)}
              />
            </div>

            <div className="mb-3">
              <label className="form-label">Valor Unitário</label>
              <input
                type="number"
                step="0.01"
                className="form-control"
                value={valor_unitario}
                onChange={(e) => setValor_unitario(e.target.value)}
              />
            </div>

            <div className="mb-3">
              <label className="form-label">ID do Fornecedor</label>
              <input
                type="number"
                className="form-control"
                value={fornecedor_id}
                onChange={(e) => setFornecedor_id(e.target.value)}
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
