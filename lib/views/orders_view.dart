import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/database/movie_db.dart';
import 'package:southsea_cinema/models/booking_record.dart';
import 'package:southsea_cinema/widgets/orders_button.dart';

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
    final Widget body;
    if (_loading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_errorMessage.isNotEmpty) {
      body = Center(child: Text(_errorMessage));
    } else if (_orders.isEmpty) {
      body = const Center(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0),
              child: Text(
                'No orders yet',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              )));
    } else {
      body = ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildOrderCard(_orders[index]);
        },
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text(appTitle, style: cinemaHeaderStyle),
          actions: const [OrdersButton()],
        ),
        body: body);
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
        return;
      }
      setState(() {
        _orders = orders;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _errorMessage = 'Could not load orders: $error';
        _loading = false;
      });
    }
  }

  Widget _buildOrderCard(OrderRecord order) {
    final Color cardColor = Theme.of(context).colorScheme.surface;
    final Color textColor = Theme.of(context).colorScheme.onSurface;

    return Card(
      color: cardColor,
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
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: textColor),
                ),
                Text(
                  '£${order.total.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 12, color: textColor),
                ),
              ],
            ),
            const SizedBox(height: 4),
            if (order.items.isEmpty)
              Text(
                order.summary,
                style: TextStyle(fontSize: 12, color: textColor),
              )
            else
              ...order.items.map((item) => Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.quantity} x ${item.title}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        Text(
                          '${item.ageRating} · ${item.date} · '
                          '${item.timeStart}-${item.timeEnd}',
                          style: TextStyle(
                            fontSize: 12,
                            color: textColor,
                          ),
                        ),
                        Text(
                          '£${(item.unitPrice * item.quantity).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: textColor,
                          ),
                        ),
                        Text(
                          item.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  )),
            const SizedBox(height: 4),
            Text(order.date, style: TextStyle(fontSize: 12, color: textColor)),
          ],
        ),
      ),
    );
  }
}
