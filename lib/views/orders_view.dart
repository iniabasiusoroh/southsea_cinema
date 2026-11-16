import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/database/movie_db.dart';
import 'package:southsea_cinema/models/booking_record.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() {
    return _OrdersViewState();
  }
}