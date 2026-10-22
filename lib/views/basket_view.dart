import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/cart_item.dart';
import 'package:southsea_cinema/repositories/cart_repository.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() {
    return _BasketViewState();
  }
}

class _BasketViewState extends State<BasketView> {
  String _confirmationMessage = '';

  @override
  Widget build(BuildContext context){
    final CartRepository cart = CartRepository.instance;
    final List<CartItem> items = cart.getItems();

    return Scaffold(
      appBar: AppBar(
        title: const Text (appTitle, style: cinemaHeaderStyle)
      )
    );
  }
}