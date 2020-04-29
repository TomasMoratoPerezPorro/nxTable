import 'package:prototip_tfg/Models/Reserva.dart';
import 'package:prototip_tfg/Models/Restaurant.dart';

final avui = DateTime.now();
final dema = avui.add(Duration(hours: 24));

final Reserva reserva1 = Reserva(0001, 1, 1, 'Morató', '608492147', 1,
    'Clients VIP', Hora(21, 30), DateTime.now(), 2);
final Reserva reserva2 = Reserva(0002, 1, 1, 'Garcia', '605367557', 3,
    'Alergico al Aguacate', Hora(21, 30), DateTime.now(), 1);
final Reserva reserva3 = Reserva(
    0003, 1, 1, 'Pascual', '934181242', 4, '', Hora(21, 30), DateTime.now(), 3);
final Reserva reserva4 = Reserva(
    0004, 1, 1, 'Pujol', '63002200', 5, '', Hora(21, 30), DateTime.now(), 2);
final Reserva reserva5 = Reserva(
    0005, 1, 1, 'Artur', '650598080', 7, '', Hora(21, 30), DateTime.now(), 2);
final Reserva reserva6 = Reserva(0006, 1, 2, 'Puigdemont', '650598080', 1, '',
    Hora(21, 30), DateTime.now(), 2);
final Reserva reserva7 = Reserva(
    0007, 1, 2, 'Harry', '650598080', 5, '', Hora(21, 30), DateTime.now(), 1);
final Reserva reserva8 = Reserva(0008, 1, 2, 'Masmitja', '650598080', 3, '',
    Hora(21, 30), DateTime.now(), 3);
final Reserva reserva9 = Reserva(
    0008, 2, 2, 'Meló', '650598080', 3, '', Hora(21, 30), DateTime.now(), 3);
final Reserva reserva10 = Reserva(
    0008, 2, 1, 'Pinya', '650598080', 3, '', Hora(21, 30), DateTime.now(), 3);
final Reserva reserva11 = Reserva(
    0008, 2, 1, 'Platja', '650598080', 3, '', Hora(21, 30), DateTime.now(), 3);
final Reserva reserva12 = Reserva(
    0008, 2, 2, 'Miró', '650598080', 3, '', Hora(21, 30), DateTime.now(), 3);
final Reserva reserva13 =
    Reserva(0008, 2, 2, 'Uruguayo', '650598080', 3, '', Hora(21, 30), dema, 3);
final Reserva reserva14 = Reserva(
    0008, 2, 1, 'Monte Pinar', '650598080', 3, '', Hora(21, 30), dema, 3);
final Reserva reserva15 =
    Reserva(0008, 2, 1, 'Chile', '650598080', 3, '', Hora(21, 30), dema, 3);
final Reserva reserva16 =
    Reserva(0008, 2, 2, 'Guateke', '650598080', 3, '', Hora(21, 30), dema, 3);

///////////////////////////////////////////////////////////////////////////////////////////

class ReservasDia {
  List<Reserva> reservas;
  DateTime data;

  ReservasDia(this.reservas, this.data);
}

List<Reserva> getReservasDia(DateTime dia, int servei, int torn) {
  List<Reserva> llistaProva = [
    reserva1,
    reserva2,
    reserva3,
    reserva4,
    reserva5,
    reserva6,
    reserva7,
    reserva8,
    reserva9,
    reserva10,
    reserva11,
    reserva12,
    reserva13,
    reserva14,
    reserva15,
    reserva16,
  ];

  List<Reserva> returnReserves = [];

  for (var reserva in llistaProva) {
    if (reserva.dia.day == dia.day) {
      if (reserva.servei == servei && reserva.torn == torn) {
        returnReserves.add(reserva);
      }
    }
  }

  return returnReserves;
}
