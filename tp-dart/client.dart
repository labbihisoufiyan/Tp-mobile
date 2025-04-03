import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> getProducts(String baseUrl) async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    
    if (response.statusCode == 200) {
      final products = jsonDecode(response.body) as List;
      print('\n=== Produits disponibles ===');
      for (var product in products) {
        print('Nom: ${product['name']}, Prix: ${product['price']}');
      }
    } else {
      print('Erreur ${response.statusCode} lors de la récupération des produits');
    }
  } catch (e) {
    print('Erreur lors de la connexion au serveur: $e');
  }
}

Future<void> addProduct(String baseUrl, Map<String, dynamic> product) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/products'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product),
    );
    
    if (response.statusCode == 201) {
      print('Produit ajouté avec succès');
    } else {
      print('Erreur ${response.statusCode} lors de l\'ajout du produit');
    }
  } catch (e) {
    print('Erreur lors de la connexion au serveur: $e');
  }
}

Future<void> getOrders(String baseUrl) async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/orders'));
    
    if (response.statusCode == 200) {
      final orders = jsonDecode(response.body) as List;
      print('\n=== Commandes disponibles ===');
      for (var order in orders) {
        print('Produit: ${order['product']}, Quantité: ${order['quantity']}');
      }
    } else {
      print('Erreur ${response.statusCode} lors de la récupération des commandes');
    }
  } catch (e) {
    print('Erreur lors de la connexion au serveur: $e');
  }
}


Future<void> addOrder(String baseUrl, Map<String, dynamic> order) async {
  // Envoi de la requête POST à l'endpoint /orders
  final response = await http.post(
    Uri.parse('$baseUrl/orders'),  // Construction de l'URL
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},  // Définition du header
    body: jsonEncode(order),  // Conversion des données en JSON
  );

  // Gestion de la réponse
  if (response.statusCode == 201) {
    print('Commande créée avec succès');  // Succès (statut 201 = Created)
  } else {
    print('Erreur lors de la création de la commande');  // Erreur
  }
}

void main() async {
  const baseUrl = 'http://localhost:3000';
  
  // Test des produits
  await getProducts(baseUrl);
  
  await addProduct(baseUrl, {
    'name': 'Ordinateur portable',
    'price': 999.99
  });
  
  await getProducts(baseUrl);
  
  // Test des commandes
  await getOrders(baseUrl);
  
  await addOrder(baseUrl, {
    'product': 'Ordinateur portable',
    'quantity': 1
  });
  
  await getOrders(baseUrl);
}