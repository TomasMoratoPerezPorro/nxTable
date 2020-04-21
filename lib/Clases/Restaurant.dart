class TaulaFisica {
  int id;
  int maxPersonas;

  TaulaFisica(this.id,this.maxPersonas);
}

List<TaulaFisica> taulesFisiquesProva = [
  TaulaFisica(1, 2),
  TaulaFisica(2, 2),
  TaulaFisica(3, 2),
  TaulaFisica(4, 2),
  TaulaFisica(5, 2),
  TaulaFisica(6, 2),
  TaulaFisica(7, 2),
  TaulaFisica(8, 2),
  TaulaFisica(9, 2),
  TaulaFisica(10, 2),
  TaulaFisica(11, 2),
  TaulaFisica(12, 4),
  TaulaFisica(13, 4),
  TaulaFisica(14, 4),
  TaulaFisica(15, 4),
  TaulaFisica(16, 4),
];

class Servei {
  int id;
  String nom;
  List<Torn> tornsList;
}

class Torn {
  int id;
  Hora horaInici;
}

class Hora {
  int hora;
  int minuts;
  Hora(this.hora, this.minuts);
}

class Restaurant {
  int id;
  String nom;
  List<TaulaFisica> taulesFisiquesList;
  List<Servei> serveisList;
}
