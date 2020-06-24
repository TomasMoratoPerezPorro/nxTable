import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototip_tfg/Models/Reserva.dart';
import 'package:prototip_tfg/Models/Taula.dart';
import 'package:prototip_tfg/controllers/CustomApi.dart';

class NewReservaProvider with ChangeNotifier {
  DateTime _actualDia = DateTime.now();
  int _numComensales;
  int _idServicio;
  String _nom;
  String _telefon;
  String _comentaris = "";
  int _idTorn;
  int _estat;
  List<int> _idTaula = [];
  bool showMissingCamps = false;
  int _numComensalesSelected = 0;
  Reserva _finalReserva;
  bool _reservaConfirmada = false;
  CustomApi api = CustomApi();

  Future<bool> saveReserva() async {
    if(_finalReserva.servei==2){
      _finalReserva.torn+=1;
    }
    try {
      var stats = await api.putNewReserva(_finalReserva);
      return true;
    } catch (ex) {
      debugPrint("DEBUG ERROR SAVING RESERVA: " + ex.toString());
      return null;
    } finally {
      /* notifyListeners(); */
    }
  }

  void confirmarReserva(bool confirmacio) {
    debugPrint("IN confirmarReserva");
    if (confirmacio) {
      _reservaConfirmada = true;
      debugPrint(_reservaConfirmada.toString());
      notifyListeners();
    } else {
      _reservaConfirmada = false;
      debugPrint(_reservaConfirmada.toString());
      notifyListeners();
    }
  }

  bool get reservaConfirmada => _reservaConfirmada;
  Reserva get finalReserva => _finalReserva;
  int get servei => _idServicio;
  int get numComensales => _numComensales;
  DateTime get actualDia => _actualDia;
  int get numComensalesSelected => _numComensalesSelected;
  List<int> get idTaula => _idTaula;

  Reserva createReservaObject(int torn) {
    var reserva = new Reserva.multiple(
        id: 0,
        servei: _idServicio,
        torn: _idTorn,
        nom: _nom,
        telefon: _telefon,
        comentaris: _comentaris,
        horaEntrada: "Hora",
        dia: _actualDia,
        estat: 2,
        numComensals: _numComensales,
        taules: _idTaula);
    this._finalReserva = reserva;
    return reserva;
  }

  void setNom(String nom) {
    this._nom = nom;
    debugPrint(_nom);
  }

  void setTelefon(String telefon) {
    this._telefon = telefon;
    debugPrint(_telefon);
  }

  void setComentaris(String comentaris) {
    this._comentaris = comentaris;
    debugPrint(_comentaris);
  }

  bool setNumComensalesSelected(int n, int id) {
    if ((_numComensalesSelected + n) > _numComensales + 1) {
      return false;
    } else {
      _numComensalesSelected += n;
      notifyListeners();
      _idTaula.add(id);
      debugPrint("id_TAULA=  " + _idTaula.toString());

      return true;
    }
  }

  void unselectTaula(Taula taula) {
    _idTaula.remove(taula.id);
    _numComensalesSelected -= taula.maxpersonas;
    notifyListeners();
    debugPrint("REMOVED");
  }

  void setDia(DateTime dia) {
    this._actualDia = dia;

    notifyListeners();
  }

  void setServei(int idServei) {
    this._idServicio = idServei;
    notifyListeners();
  }

  void setTorn(int idTorn) {
    this._idTorn = idTorn;
    /* notifyListeners(); */
  }

  String getDia() {
    var dt = _actualDia;
    var newFormat = DateFormat("EEEE, dd MMMM");
    String updatedDt = newFormat.format(dt);
    return updatedDt;
  }

  void setNumComensales(int i) {
    this._numComensales = i;
    notifyListeners();
  }

  bool canProceed(int index) {
    if (index == 0) {
      if (_numComensales != null && _idServicio != null && _actualDia != null) {
        return true;
      } else {
        showMissingCamps = true;
        notifyListeners();
        return false;
      }
    } else if (index == 1) {
      if (_numComensalesSelected >= _numComensales) {
        showMissingCamps = false;
        return true;
      } else {
        showMissingCamps = true;
        notifyListeners();
        return false;
      }
    } else if (index == 2) {
      if (_nom == null || _telefon == null) {
        showMissingCamps = true;
        notifyListeners();
        return false;
      } else if (_nom.length > 2 || _telefon.length > 9) {
        showMissingCamps = false;
        return true;
      } else {
        showMissingCamps = true;
        notifyListeners();
        return false;
      }
    }
  }

  void resetData() {
    _actualDia = DateTime.now();
    this._numComensales = null;
    this._idServicio = null;
    this.showMissingCamps = false;
    this._nom = null;
    this._comentaris = null;
    this._telefon = null;
    this._idTaula = [];
    this._numComensalesSelected = 0;
    this._reservaConfirmada = false;
    this._finalReserva=null;
    
  }

  void resetDataStep2() {
    this._idTaula = [];
    this._numComensalesSelected = 0;
  }
}
