export default function TituloLista(props) {
  
  return (
    <div className="container">
      <div className="row justify-content-md-center mt-4">
        <div className="col">
          <div className="alert alert-dark" role="alert">
            <h4 className="alert-heading">{props.titulo}</h4>
            <p>{props.descrição}</p>
            <hr />
            <a href={props.rota} className="btn btn-dark btn-md">
              {props.botao}
            </a>
          </div>
        </div>
      </div>
      <br />
    </div>
  );
}