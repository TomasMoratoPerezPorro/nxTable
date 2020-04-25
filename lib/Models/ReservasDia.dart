import 'package:prototip_tfg/Models/Reserva.dart';
import 'package:prototip_tfg/Models/Restaurant.dart';

class ReservasDia {
  List<Reserva> reservas;
  DateTime data;

  ReservasDia(this.reservas, this.data);
}

List<Reserva> getReservasDia(DateTime dia, int servei, int torn) {
  Reserva reserva1 = Reserva(
      0001, 1, 1, 'Morató', '608492147', 1, 'Clients VIP', Hora(21, 30), 2);
  Reserva reserva2 = Reserva(0002, 1, 1, 'Garcia', '605367557', 3,
      'Alergico al Aguacate', Hora(21, 30), 1);
  Reserva reserva3 =
      Reserva(0003, 1, 1, 'Pascual', '934181242', 4, '', Hora(21, 30), 3);
  Reserva reserva4 =
      Reserva(0004, 1, 1, 'Pujol', '63002200', 5, '', Hora(21, 30), 2);
  Reserva reserva5 =
      Reserva(0005, 1, 1, 'Artur', '650598080', 7, '', Hora(21, 30), 2);
  Reserva reserva6 =
      Reserva(0006, 1, 2, 'Puigdemont', '650598080', 1, '', Hora(21, 30), 2);
  Reserva reserva7 =
      Reserva(0007, 1, 2, 'Harry', '650598080', 5, '', Hora(21, 30), 2);
  Reserva reserva8 =
      Reserva(0008, 1, 2, 'Masmitja', '650598080', 3, '', Hora(21, 30), 2);

  List<Reserva> llistaProva = [
    reserva1,
    reserva2,
    reserva3,
    reserva4,
    reserva5,
    reserva6,
    reserva7,
    reserva8,
  ];

  List<Reserva> returnReserves = [];

  for (var reserva in llistaProva) {
    if (reserva.servei == servei && reserva.torn == torn) {
      returnReserves.add(reserva);
    }
  }

  return returnReserves;
}
