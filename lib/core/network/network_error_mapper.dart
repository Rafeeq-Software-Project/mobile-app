import 'package:rafeeq_app/core/network/network_failure.dart';
import 'package:rafeeq_app/generated/l10n.dart';

class NetworkErrorMapper {
  static String toUserMessage(NetworkFailure failure, context) {
    return failure.when(
      noInternet: () => S.of(context).errorNoInternet,
      unauthorized: () => S.of(context).errorUnauthorized,
      notFound: () => S.of(context).errorNotFound,
      serverError: (msg) => msg ?? S.of(context).errorServer,
      timeout: () => S.of(context).errorTimeout,
      unknown: (msg) => S.of(context).errorUnknown,
    );
  }
}
