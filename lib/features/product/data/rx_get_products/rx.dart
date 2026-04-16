import 'package:rxdart/rxdart.dart';
import '../../../../helpers/error_message_handler.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class GetProductsRx extends RxResponseInt {
  final api = GetProductsApi.instance;

  GetProductsRx({required super.empty, required super.dataFetcher});

  ValueStream get fileData => dataFetcher.stream;

  Future<bool> featchProducts({int pageNum = 1, int perPage = 100}) async {
    try {
      Map data = await api.getProductsData(pageNum: pageNum, perPage: perPage);
      return await handleSuccessWithReturn(data);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    ErrorMessageHandler.showErrorToast(error); // Just one call!
    return false;
  }
}
