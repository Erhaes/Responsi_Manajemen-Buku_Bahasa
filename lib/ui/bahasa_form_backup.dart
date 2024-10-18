import 'package:flutter/material.dart';
import '../bloc/bahasa_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/bahasa.dart';
import 'bahasa_page.dart';

// ignore: must_be_immutable
class BahasaForm extends StatefulWidget {
  Bahasa? bahasa;
  BahasaForm({super.key, this.bahasa});
  @override
  _BahasaFormState createState() => _BahasaFormState();
}

class _BahasaFormState extends State<BahasaForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "Tambah Terjemahan";
  String tombolSubmit = "Tambah";
  final _bahasaAsliTextboxController = TextEditingController();
  final _bahasaTerjemahTextboxController = TextEditingController();
  final _namaTranslatorTextboxController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.bahasa != null) {
      setState(() {
        judul = "Edit Detail Terjemahan";
        tombolSubmit = "Edit";
        _bahasaAsliTextboxController.text = widget.bahasa!.bahasaAsli!;
        _bahasaTerjemahTextboxController.text = widget.bahasa!.bahasaTerjemah!;
        _namaTranslatorTextboxController.text = widget.bahasa!.namaTranslator!;
      });
    } else {
      judul = "Tambah Terjemahan";
      tombolSubmit = "Tambah";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: Column(
        children: [
          Expanded(child: Container(
            
          )),
          Expanded(child: Form(
                    key: _formKey,
                    child: Column(
          children: [
            _bahasaAsliTextField(),
            const SizedBox(height: 20,),
            _bahasaTerjemahTextField(),
            const SizedBox(height: 20,),
            _namaTranslatorTextField(),
            const SizedBox(height: 20,),
            _buttonSubmit()
          ],
                    ),
                  )),
          Expanded(child: Container(
            height: 100,
          ))
        ],
      ),
    );
  }

//Membuat Textbox Kode Produk
  Widget _bahasaAsliTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Bahasa Asli"),
      keyboardType: TextInputType.text,
      controller: _bahasaAsliTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Keterangan bahasa asal wajib diisi";
        }
        return null;
      },
    );
  }

//Membuat Textbox Nama Produk
  Widget _bahasaTerjemahTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Terjemahan"),
      keyboardType: TextInputType.text,
      controller: _bahasaTerjemahTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Berikan keterangan bahasa terjemahan";
        }
        return null;
      },
    );
  }

//Membuat Textbox Harga Produk
  Widget _namaTranslatorTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Penerjemah"),
      controller: _namaTranslatorTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Masukkan nama penerjemah";
        }
        return null;
      },
    );
  }

  //Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.bahasa != null) {
                //kondisi update bahasa
                ubah();
              } else {
                //kondisi tambah bahasa
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Bahasa addBahasa = Bahasa(id: null);
    addBahasa.bahasaAsli = _bahasaAsliTextboxController.text;
    addBahasa.bahasaTerjemah = _bahasaTerjemahTextboxController.text;
    addBahasa.namaTranslator = _namaTranslatorTextboxController.text;
    BahasaBloc.addBahasa(bahasa: addBahasa).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const BahasaPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Tambah Data Gagal",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }


  ubah() {
    setState(() {
      _isLoading = true;
    });
    Bahasa updateBahasa = Bahasa(id: widget.bahasa!.id!);
    updateBahasa.bahasaAsli = _bahasaAsliTextboxController.text;
    updateBahasa.bahasaTerjemah = _bahasaTerjemahTextboxController.text;
    updateBahasa.namaTranslator = _namaTranslatorTextboxController.text;
    BahasaBloc.updateBahasa(bahasa: updateBahasa).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const BahasaPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Edit data gagal",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}



