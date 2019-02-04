import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_ticket/main.dart';

class TicketUtils{

  static Future<double> calculateDifferenceAsync(double totalAmount) async{
    //TODO standard ticket value preferences

    //TODO Valuta variab statica in main

    var ticketPrice = await getTicketPrice();

    int numTickets = calculateNumberOfTickets(totalAmount, ticketPrice);

    return totalAmount - (numTickets * ticketPrice);

  }

  static double calculateDifference(double totalAmount){
    int numTickets = calculateNumberOfTickets(totalAmount, SmartTicketApp.ticketPrice);
    return totalAmount - (numTickets * SmartTicketApp.ticketPrice);
  }

  static int calculateNumberOfTickets(double totalAmount, double ticketPrice) {
    return totalAmount != 0 ? (totalAmount / ticketPrice).truncate() : 0;
  }

  static Future<double> getTicketPrice() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
   return pref.getDouble(SmartTicketApp.PREFERENCE_TICKET_PRICE) ?? 0;
  }

}