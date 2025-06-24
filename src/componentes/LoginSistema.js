import React from "react";
import logo from '../assets/img.webp';

export default function LoginSistema() {
  return (
    <div
      className="container d-flex justify-content-center align-items-center"
      style={{ minHeight: "100vh" }}
    >
      <div className="card shadow p-4 rounded-5" style={{ width: "22rem" }}>
        <img
          src={logo}
          className="card-img-top mb-3 mx-auto d-block"
          alt="Imagem Login"
          style={{ width: 200 }}
        />
        <div className="card-body">
          <div className="mb-3">
            <label htmlFor="email" className="form-label">
              E-mail
            </label>
            <input
              type="email"
              className="form-control"
              id="email"
              placeholder="Digite seu e-mail"
            />
          </div>
          <div className="mb-3">
            <label htmlFor="senha" className="form-label">
              Senha
            </label>
            <input
              type="password"
              className="form-control"
              id="senha"
              placeholder="Digite sua senha"
            />
          </div>
          <button className="btn btn-dark w-100">
            Login
          </button>
        </div>
      </div>
    </div>
  );
}
