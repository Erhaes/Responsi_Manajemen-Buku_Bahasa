import 'package:flutter/material.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/bahasa_bloc.dart';
import '/model/bahasa.dart';
import '/ui/bahasa_detail.dart';
import '/ui/bahasa_form.dart';
import 'login_page.dart';

class BahasaPage extends StatefulWidget {
  const BahasaPage({Key? key}) : super(key: key);

  @override
  _BahasaPageState createState() => _BahasaPageState();
}

class _BahasaPageState extends State<BahasaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Buku Terjemahan'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BahasaForm()));
                },
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: BahasaBloc.getBahasas(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListBahasa(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListBahasa extends StatelessWidget {
  final List? list;

  const ListBahasa({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemBahasa(
            bahasa: list![i],
          );
        });
  }
}

class ItemBahasa extends StatelessWidget {
  final Bahasa bahasa;

  const ItemBahasa({Key? key, required this.bahasa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailBahasa(
                      bahasa: bahasa,
                    )));
      },
      child: Card(
        child: ListTile(
          title: Text(bahasa.bahasaAsli!),
          subtitle: Text(bahasa.bahasaTerjemah!),
          trailing: Text(bahasa.namaTranslator!),
        ),
      ),
    );
  }
}
