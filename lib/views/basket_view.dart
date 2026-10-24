import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/cart_item.dart';
import 'package:southsea_cinema/models/movie.dart';
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

  Widget _buildEmptyState(){
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.0),
        child: Text (
          'Your basket is empty',
          style: TextStyle(fontSize: 16, color: cinemaFontWhite)
        )
      )
    );
  }

  @override
  Widget build(BuildContext context){
    final CartRepository cart = CartRepository.instance;
    final List<CartItem> items = cart.getItems();

    final Widget content;
    if (items.isEmpty) {
      if (_confirmationMessage.isNotEmpty) {
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEmptyState(),
            const SizedBox(height: 12),
            Text(
              _confirmationMessage,
              style:const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        );
      }else{
        content = _buildEmptyState();
      }
    } else {
      content = _buildBasketList(cart, items);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text ('Southsea Cinema', style: cinemaHeaderStyle)
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: content,
      ),
    );
  }

  Widget _buildLineItem(CartRepository cart, CartItem item, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children:[
          SizedBox(
            width: 115,
            child: Text(
              '${item.quantity} Tickets',
              style: const TextStyle(
                color: cinemaBrand, 
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item.quantity} Standard',
                  style: const TextStyle(fontWeight: FontWeight.w600)
                ),
                const SizedBox(height:4),
                const Text(
                  'PLACEHOLDER',
                  style: TextStyle(
                    color: cinemaFontWhite,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Text(
              '£${item.lineTotal.toStringAsFixed(2)}',
              style: const TextStyle(
                color: cinemaFontWhite,
              ),
              
            ),
            
          ),
          Container(
            color: cinemaBrand,
            child: IconButton(
              icon: const Icon(
                Icons.delete_outline,
                color: cinemaFontWhite),

                onPressed: () {
                  setState((){
                    cart.removeItem(index);
                  });
                },
            ),
             
          )
          

          // IconButton(
          //   icon: const Icon(Icons.delete_outline, color: Colors.red),
          //   onPressed: (){
          //     setState((){
          //       cart.removeItem(index);
          //     });
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String value, {bool emphasise = false}) {
    final TextStyle style;
    if (emphasise) {
      style = const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    } else {
      style = const TextStyle(color: cinemaFontWhite);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style)
        ],
      ),
    );
  }


  Widget _buildBasketList(CartRepository cart, List<CartItem> items){
    final List<Widget> children = [];

    children.add(const Text('MY ORDER', style: cinemaHeaderStyle));
    children.add(const SizedBox(height: 16));

    for (int index = 0; index < items.length; index++) {
      final CartItem item = items[index];
      children.add(_buildLineItem(cart, item, index));
    }

    children.add(const SizedBox(height: 24));
    children.add(
      _buildTotalRow(
        'Items subtotal',
        '£${cart.getTotal().toStringAsFixed(2)}',
      ),
    );

    children.add(
      _buildTotalRow(
        'Total to pay',
        '£${cart.getTotal()}',
        emphasise: true,
      )
    );
    children.add(const SizedBox(height: 24));

    children.add(
      SizedBox(
        width:double.infinity,
        child: PrimaryButton(
          label: 'Checkout',
          onPressed: () {
            setState((){
              cart.clear();
              _confirmationMessage = 'Thanks, your order is on its way';
            });
          },
        ),
      ),
    );

    if (_confirmationMessage.isNotEmpty) {
      children.add(const SizedBox(height: 12));
      children.add(
        Text(
          _confirmationMessage,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

// build the basket item card