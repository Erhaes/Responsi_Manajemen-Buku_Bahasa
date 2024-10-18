import 'package:bahasa_buku/ui/bahasa_page.dart';
import 'package:flutter/material.dart';
import '../bloc/bahasa_bloc.dart';
import '../model/bahasa.dart';
import '../widget/warning_dialog.dart';


// ignore: must_be_immutable
class BahasaForm extends StatefulWidget {
  Bahasa? bahasa;

  BahasaForm({Key? key, this.bahasa}) : super(key: key);

  @override
  _BahasaFormState createState() => _BahasaFormState();
}

class _BahasaFormState extends State<BahasaForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "Tambah Buku Terjemahan";
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
        judul = "Edit Keterangan Buku";
        tombolSubmit = "Edit";
        _bahasaAsliTextboxController.text = widget.bahasa!.bahasaAsli!;
        _bahasaTerjemahTextboxController.text = widget.bahasa!.bahasaTerjemah!;
        _namaTranslatorTextboxController.text = widget.bahasa!.namaTranslator!;
      });
    } else {
      judul = "Tambah Buku Terjemahan";
      tombolSubmit = "Tambah";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20,),
                _bahasaAsliTextField(),
                const SizedBox(height: 20,),
                _bahasaTerjemahTextField(),
                const SizedBox(height: 20,),
                _namaTranslatorTextField(),
                const SizedBox(height: 20,),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

//Membuat Textbox Kode Produk
  Widget _bahasaAsliTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Bahasa Edisi Asli"),
      keyboardType: TextInputType.text,
      controller: _bahasaAsliTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Isi Bahasa Asli Buku!";
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
          return "Isi bahasa terjemahannya!";
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
          return "Tambahkan keterangan penerjemah";
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
                //kondisi update produk
                ubah();
              } else {
                //kondisi tambah produk
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
    Bahasa createBahasa = Bahasa(id: null);
    createBahasa.bahasaAsli = _bahasaAsliTextboxController.text;
    createBahasa.bahasaTerjemah = _bahasaTerjemahTextboxController.text;
    createBahasa.namaTranslator = _namaTranslatorTextboxController.text;
    BahasaBloc.addBahasa(bahasa: createBahasa).then((value) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const BahasaPage()));
    }, onError: (error) {
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Tambah data gagal",
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
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const BahasaPage()));
    }, onError: (error) {
      showDialog(
          // ignore: use_build_context_synchronously
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
