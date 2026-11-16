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

class _OrdersViewState extends State<OrdersView> {
    List<OrderRecord> _orders = [];
    bool _loading = true;
    String _errorMessage = '';

    @override
    Widget build(BuildContext context) {
      return const Placeholder();
    }

    @override
    void initState() {
      super.initState();
      _loadOrders();
    }

    Future<void> _loadOrders() async {
      try {
        final List<OrderRecord> orders = 
          await MovieDatabase.instance.getAllOrders();

        if (!mounted) {
          _orders = orders;
          _loading = false;
        }
      } catch(error) {
        if (!mounted) {
          return;
        }
        setState((){
          _errorMessage = 'Could not load orders: $error';
          _loading = false;
        });
      }
    }

    Widget _buildOrderCard(OrderRecord order) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Booking #${order.bookingNumber}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('£${order.total.toStringAsFixed(2)}')
                ]
              ),
              const SizedBox(height: 4),
              Text(order.summary),
              const SizedBox(height: 4),
              Text(
                order.date,
                style: const TextStyle(fontSize: 12, color: Colors.black54)
              ),
            ]
          )
        )
      );
    }
  }