import 'package:flutter/material.dart';
import '../bloc/bahasa_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/bahasa.dart';
import 'bahasa_form.dart';
import 'bahasa_page.dart';

// ignore: must_be_immutable
class DetailBahasa extends StatefulWidget {
  Bahasa? bahasa;

  DetailBahasa({Key? key, this.bahasa}) : super(key: key);

  @override
  _DetailBahasaState createState() => _DetailBahasaState();
}

class _DetailBahasaState extends State<DetailBahasa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Terjemahan'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Bahasa Edisi Asli : ${widget.bahasa!.bahasaAsli}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Terjemahan : ${widget.bahasa!.bahasaTerjemah}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Penerjemah : ${widget.bahasa!.namaTranslator}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BahasaForm(
                  bahasa: widget.bahasa!,
                ),
              ),
            );
          },
        ),
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        //tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            BahasaBloc.deleteBahasa(id: widget.bahasa!.id!).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const BahasaPage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
        //tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
