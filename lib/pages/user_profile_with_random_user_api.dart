import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:training_proj/widgets/app_text.dart';

class UserProfileWithRandomUserApi extends StatefulWidget {
  const UserProfileWithRandomUserApi({super.key});

  @override
  State<UserProfileWithRandomUserApi> createState() => _UserProfileWithRandomUserApiState();
}

class _UserProfileWithRandomUserApiState extends State<UserProfileWithRandomUserApi> {

  //Utilisateurs récupérés depuis l'API
  List<dynamic> users = [];

  //Fonction pour récuperer les users
  Future<void> fetchUsers() async {
    final url = Uri.parse("https://randomuser.me/api/?results=20&seed=api&nat=us");
    final client = http.Client();
    final response = await client.get(url);

    if (response.statusCode == 200){
      Map<String, dynamic> decodedData = json.decode(response.body);
      setState(() {
        users = decodedData["results"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back)),
        title: Text("Liste des Utilisateurs"),
      ),
      body: users.isEmpty
          ? Center(child: Text("Clique sur le bouton pour charger les utilisateurs"))
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final name = "${user['name']['title']} ${user['name']['first']} ${user['name']['last']}";
          final email = user['email'];
          final pictureUrl = user['picture']['medium'];
          final phoneNumber = user['phone'];

          return ListTile(

            onTap: () {
              // Plus de détails sur l'user
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: AppText(text: "Profil", textAlign: TextAlign.center, fontSize: 25, color: Colors.blue, fontWeight: FontWeight.bold,),
                  content: SizedBox(
                    height: 300,
                    child: Column(
                      children: [
                        //Image de profil
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(pictureUrl),
                          ),
                        ),

                        SizedBox(height: 25,),

                        //Nom Prenom
                        AppText(text: name),

                        SizedBox(height: 25,),

                        //Mail
                        AppText(text: email),

                        SizedBox(height: 25,),

                        //Numero de téléphone
                        AppText(text:  phoneNumber),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Fermer"),
                    ),
                  ],
                ),
              );
            },

            leading: CircleAvatar(
              backgroundImage: NetworkImage(pictureUrl),
            ),
            title: Text(name),
            subtitle: Text(email),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        onPressed: fetchUsers,
        child: Icon(Icons.update),
      ),
    );
  }
}
