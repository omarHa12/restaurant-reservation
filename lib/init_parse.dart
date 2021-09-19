import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'constants.dart';


Future<bool> initData() async {
    await Parse().initialize(
      keyApplicationId,
      keyServerUrl,
      clientKey: keyClientKey,
      debug: keyDebug,
    );

    return (await Parse().healthCheck()).success;
}
