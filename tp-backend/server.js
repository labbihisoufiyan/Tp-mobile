const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');

const app = express();
const port = 3000;

app.use(bodyParser.json());

// Fonctions pour gérer les données
const loadData = () => {
  try {
    const data = fs.readFileSync('data.json', 'utf8');
    return JSON.parse(data);
  } catch (err) {
    return { products: [], orders: [] };
  }
};

const saveData = (data) => {
  fs.writeFileSync('data.json', JSON.stringify(data, null, 2));
};

// Routes de base
app.get('/', (req, res) => {
  res.send('API Backend fonctionne!');
});

// Routes pour les produits
app.get('/products', (req, res) => {
  const data = loadData();
  res.json(data.products);
});

app.post('/products', (req, res) => {
  const data = loadData();
  const newProduct = req.body;
  
  // Validation simple
  if (!newProduct.name || !newProduct.price) {
    return res.status(400).send('Nom et prix sont requis');
  }
  
  data.products.push(newProduct);
  saveData(data);
  res.status(201).json(newProduct);
});

// Routes pour les commandes
app.get('/orders', (req, res) => {
  const data = loadData();
  res.json(data.orders);
});

app.post('/orders', (req, res) => {
  const data = loadData();
  const newOrder = req.body;
  
  // Validation simple
  if (!newOrder.product || !newOrder.quantity) {
    return res.status(400).send('Produit et quantité sont requis');
  }
  
  data.orders.push(newOrder);
  saveData(data);
  res.status(201).json(newOrder);
});

// Démarrer le serveur
app.listen(port, () => {
  console.log(`Serveur API démarré sur http://localhost:${port}`);
});
// Dans server.js (route POST /products)
const exists = data.products.some(p => p.name === newProduct.name && p.price === newProduct.price);
if (exists) return res.status(400).send('Produit déjà existant');
// Dans server.js
if (typeof newProduct.price !== 'number') {
  return res.status(400).send('Le prix doit être un nombre');
}