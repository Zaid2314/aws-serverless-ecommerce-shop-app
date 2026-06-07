import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/models/cart_model.dart';


class CartNotifier extends Notifier<Map<String,CartModel>>{
  @override
  Map<String,CartModel> build(){
    return {};
  }

  void addProduct(CartModel model){
    state = {...state, model.id: model};
  }
}


final cartProvider = NotifierProvider<CartNotifier, Map<String,CartModel>>(
  CartNotifier.new,
);