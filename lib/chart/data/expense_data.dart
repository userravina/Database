import 'dart:math';

import '../model/custom_model.dart';


final rand = Random();
final List<double> weeklySpending = [
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
];

_generateExpenses() {
  List<CostModel> costModel = [
    CostModel(name: 'Item 0', cost: rand.nextDouble() * 90),
    CostModel(name: 'Item 1', cost: rand.nextDouble() * 90),
    CostModel(name: 'Item 2', cost: rand.nextDouble() * 90),
    CostModel(name: 'Item 3', cost: rand.nextDouble() * 90),
    CostModel(name: 'Item 4', cost: rand.nextDouble() * 90),
    CostModel(name: 'Item 5', cost: rand.nextDouble() * 90),
  ];
  return costModel;
}
