import 'base_contract.dart';

abstract class BasePresenter<T extends BaseContract> {
  final T contract;

  BasePresenter(this.contract);
}