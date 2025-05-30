import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QueryLauncherPage extends StatefulWidget {
  const QueryLauncherPage({super.key});

  @override
  State<QueryLauncherPage> createState() => _QueryLauncherPageState();
}

class _QueryLauncherPageState extends State<QueryLauncherPage> {
  String _method = 'GET';
  String _response = '';

  final _urlController = TextEditingController();
  final _bodyController = TextEditingController();

  final _methods = ['GET', 'POST', 'PUT', 'DELETE'];

  /// Envoie une requête HTTP selon la méthode choisie
  Future<void> sendRequest() async {
    final client = http.Client();
    final uri = Uri.tryParse(_urlController.text.trim());

    // Vérifie si l'URL est valide
    if (uri == null) {
      setState(() {
        _response = '🚫 URL invalide.';
      });
      return;
    }

    http.Response response;

    try {
      // Switch entre les différentes méthodes HTTP
      switch (_method) {
        case 'POST':
          response = await client.post(
            uri,
            headers: {"Content-Type": "application/json"},
            body: _bodyController.text,
          );
          break;
        case 'PUT':
          response = await client.put(
            uri,
            headers: {"Content-Type": "application/json"},
            body: _bodyController.text,
          );
          break;
        case 'DELETE':
          response = await client.delete(uri);
          break;
        case 'GET':
        default:
          response = await client.get(uri);
      }

      // Gère la réponse
      if (response.statusCode >= 200 && response.statusCode < 300) {
        dynamic data;
        try {
          data = json.decode(response.body);
          // Formattage JSON lisible
          _response = const JsonEncoder.withIndent('  ').convert(data);
        } catch (_) {
          _response = response.body;
        }

        setState(() {
          _response = '✅ Status: ${response.statusCode}\n\n$_response';
        });
      } else {
        setState(() {
          _response =
          '❌ Erreur ${response.statusCode} : ${response.reasonPhrase}\n\n${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _response = '🔥 Exception : $e';
      });
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎯 API Tester'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [

            /// Choix de la méthode + champ URL + bouton
            Row(
              children: [
                // Dropdown de méthode
                DropdownButton<String>(
                  value: _method,
                  onChanged: (val) => setState(() => _method = val!),
                  items: _methods
                      .map((method) => DropdownMenuItem(
                    value: method,
                    child: Text(method),
                  ))
                      .toList(),
                ),
                const SizedBox(width: 12),

                // Champ de saisie URL
                Expanded(
                  child: TextField(
                    controller: _urlController,
                    decoration: const InputDecoration(
                      labelText: 'Entrez l\'URL',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Bouton envoyer
                ElevatedButton(
                  onPressed: sendRequest,
                  child: const Text('Envoyer'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Champ body (si méthode POST ou PUT)
            if (_method == 'POST' || _method == 'PUT') ...[
              const Text('Corps (JSON) :'),
              const SizedBox(height: 8),
              TextField(
                controller: _bodyController,
                maxLines: 6,
                decoration: const InputDecoration(
                  hintText: '{ "nom": "Exemple" }',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
            ],

            /// Affichage de la réponse
            const Text('Réponse :',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              color: Colors.grey[100],
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SelectableText(
                  _response,
                  style: const TextStyle(fontFamily: 'Courier'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
