import { BrowserRouter, Routes, Route, useLocation } from 'react-router-dom'
import './App.css';
import Menu from './componentes/Menu';
import Home from './paginas/Home';
import ListaFornecedor from './paginas/ListaFornecedor';
import FormFornecedor from './paginas/FormFornecedor';
import ListaProduto from './paginas/ListaProduto';
import FormProduto from './paginas/FormProduto';
import LoginSistema from './componentes/LoginSistema';
import FormEstoque from './paginas/FormEstoque';
import FormBaixaEstoque from './paginas/FormBaixaEstoque';
import ListaUsuario from './paginas/ListaUsuario';
import FormUsuario from './paginas/FormUsuario'; 

function AppContent() {
  const location = useLocation();

  const hideMenuPaths = ['/login']; // rotas onde o Menu não aparece

  return (
    <>
      {!hideMenuPaths.includes(location.pathname) && <Menu />}

      <Routes>
        <Route path='/' element={<Home />} />
        <Route path='/home' element={<Home />} />
        <Route path='/gerenciaestoque' element={<FormEstoque />} /> --aqui é dada a entrada de um produto no estoque
        <Route path="/baixaestoque/:id" element={<FormBaixaEstoque />} />-- aqui é a baixa do estoque
        <Route path='/gerenciaestoque/:id' element={<FormEstoque />} />

        <Route path='/login' element={<LoginSistema />} />
        <Route path='/listausuario' element={<ListaUsuario />} />
        <Route path='/cadastrousuario' element={<FormUsuario />} />

        <Route path='/listafornecedor' element={<ListaFornecedor />} />
        <Route path='/cadastrofornecedor' element={<FormFornecedor />} />
        <Route path='/cadastrofornecedor/:id' element={<FormFornecedor />} />

        <Route path='/listaproduto' element={<ListaProduto />} />
        <Route path='/cadastroproduto' element={<FormProduto />} />
        <Route path='/cadastroproduto/:id' element={<FormProduto />} />

        <Route path='/listaproduto' element={<ListaProduto />} />
        <Route path='/cadastroproduto' element={<FormProduto />} />
        <Route path='/cadastroproduto/:id' element={<FormProduto />} />

        <Route path='*' element={<Home />} />
      </Routes>
    </>
  );
}

function App() {
  return (
    <BrowserRouter>
      <AppContent />
    </BrowserRouter>
  );
}

export default App;