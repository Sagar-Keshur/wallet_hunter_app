import 'package:logger/logger.dart';

import '../../dependency_manager/dependency_manager.dart';
import '../exceptions/app_exception.dart';
import '../exceptions/no_internet_exception.dart';
import '../services/network/network_info.dart';

class ApiHelper {
  ApiHelper({NetworkInfo? networkInfo, Logger? logger})
    : _networkInfo = networkInfo ?? getIt<NetworkInfo>(),
      _logger = logger ?? getIt<Logger>();

  final NetworkInfo _networkInfo;
  final Logger _logger;

  Future<T> safeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      await _networkInfo.checkInternet();
      final response = await apiCall();
      return response;
    } on Exception catch (e) {
      if (e is NoInternetException) {
        throw NoInternetException(e.message);
      } else {
        _logger.e('From Api Helper default $e');
        throw AppException();
      }
    }
  }
}
