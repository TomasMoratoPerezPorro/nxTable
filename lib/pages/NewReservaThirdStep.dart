import 'package:flutter/material.dart';
import 'package:prototip_tfg/providers/NewReservaProvider.dart';
import 'package:prototip_tfg/providers/SeleccioTaulaProvider.dart';
import 'package:prototip_tfg/widgets/newReservaPageWidgets/TopInfoBar.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

class NewReservaThirdStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          TopInfoBar(text: "Introduce la información de contacto: "),
          ContactInfoForm(),
        ],
      ),
    );
  }
}

class ContactInfoForm extends StatefulWidget {
  const ContactInfoForm({
    Key key,
  }) : super(key: key);

  @override
  _ContactInfoFormState createState() => _ContactInfoFormState();
}

class _ContactInfoFormState extends State<ContactInfoForm> {
  TextEditingController _name = TextEditingController();
  TextEditingController _telefon = TextEditingController();
  TextEditingController _notes = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final newReservaProvider =
        Provider.of<NewReservaProvider>(context, listen: true);
    newReservaProvider.setTorn(
        Provider.of<SeleccioTaulaProvider>(context, listen: false).torn);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
          width: double.infinity,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Información de contacto:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        newReservaProvider.showMissingCamps
                            ? Icon(Icons.announcement, color: Colors.red)
                            : SizedBox(width: 2),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _name,
                      textInputAction: TextInputAction.next,
                      decoration:
                          InputDecoration(hintText: "Nombre y Apellidos"),
                      onChanged: (contingut) {
                        newReservaProvider.setNom(contingut);
                      },
                      onFieldSubmitted: (contingut) {
                        FocusScope.of(context).nextFocus();
                        newReservaProvider.setNom(contingut);
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _telefon,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration:
                          InputDecoration(hintText: "Telefono de Contacto"),
                      onChanged: (contingut) {
                        newReservaProvider.setTelefon(contingut);
                      },
                      onFieldSubmitted: (contingut) {
                        FocusScope.of(context).nextFocus();
                        newReservaProvider.setTelefon(contingut);
                      },
                    ),
                    SizedBox(height: 50),
                    Text(
                      "Comentarios:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    TextFormField(
                      controller: _notes,
                      decoration: InputDecoration(hintText: "Notas"),
                      onChanged: (contingut) {
                        newReservaProvider.setComentaris(contingut);
                      },
                      onFieldSubmitted: (contingut) {
                        newReservaProvider.setComentaris(contingut);
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
