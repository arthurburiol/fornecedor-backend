import axios from 'axios';

async function solicitarFrete(req, res) {
    try {
        const response = await axios.get(`http://localhost:6000/frete/${req.body.cep1}/${req.body.cep2}`);
        res.send(response.data); // envia os dados recebidos da API externa
    } catch (error) {
        console.error('Erro ao solicitar frete:', error.message);
        res.status(500).send({ erro: 'Erro ao buscar frete' });
    }
}

async function solicitarDespacho(req, res) {
    try {
        const response = await axios.get('http://localhost:6000/despacho');
        res.send(response.data); // Envia os dados recebidos da API externa
    } catch (error) {
        console.error('Erro ao solicitar despacho:', error.message);
        res.status(500).send({ erro: 'Erro ao buscar despacho' });
    }
}

export default { solicitarFrete, solicitarDespacho };
