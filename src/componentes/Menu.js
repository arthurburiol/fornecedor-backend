import React from 'react';

export default function Menu() {
  return (
    <>
      {/* NAVBAR SUPERIOR COM LOGO E LOGIN */}
      <nav className="navbar bg-dark">
        <div className="container d-flex justify-content-between align-items-center">
          <a className="navbar-brand text-white fw-bold" href="/">
            Fornecedor
          </a>
          <a className="btn btn-primary" href="/listausuario" >
            Usuarios
          </a>
        </div>
      </nav>

      {/* NAVBAR INFERIOR COM OS LINKS DO SISTEMA */}
      <nav className="navbar navbar-expand-lg bg-dark">
        <div className="container-fluid">
          <button
            className="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navbarNavAltMarkup"
            aria-controls="navbarNavAltMarkup"
            aria-expanded="false"
            aria-label="Toggle navigation"
          >
            <span className="navbar-toggler-icon" />
          </button>

          <div className="collapse navbar-collapse justify-content-center" id="navbarNavAltMarkup">
            <div className="navbar-nav">
              <a className="nav-link text-white" href="/menu">
                Estoque de Produtos
              </a>
              <a className="nav-link text-white" href="/listaproduto">
                Produtos
              </a>
              <a className="nav-link text-white" href="/listafornecedor">
                Fornecedores
              </a>
            </div>
          </div>
        </div>
      </nav>
    </>
  );
}
