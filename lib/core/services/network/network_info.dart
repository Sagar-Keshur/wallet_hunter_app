import '../../../dependency_manager/dependency_manager.dart';
import '../../exceptions/no_internet_exception.dart';
import 'data_connection_checker.dart';

class NetworkInfo {
  NetworkInfo() : connectionChecker = getIt.get<DataConnectionChecker>();

  final DataConnectionChecker connectionChecker;

  Future<bool> get isConnected => connectionChecker.hasConnection;

  Future<bool> get isConnectedConcrete => connectionChecker.hasConnection;

  Future<void> checkInternet() async {
    if (!(await isConnected)) {
      throw NoInternetException();
    }
  }
}
