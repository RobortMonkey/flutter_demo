import 'package:fluro/fluro.dart';
import 'package:fluro/src/router.dart';
import 'package:flutterapp/routers/router_init.dart';
import 'package:flutterapp/store/page/store_audit_page.dart';
import 'package:flutterapp/store/page/store_audit_result_page.dart';

class StoreRouter implements IRouterProvider {
  static String auditPage = '/store/audit';
  static String auditResultPage = '/store/auditResult';

  @override
  void initRouter(Router router) {
    router.define(auditPage,
        handler: Handler(handlerFunc: (_, params) => StoreAuditPage()));
    router.define(auditResultPage,
        handler: Handler(handlerFunc: (_, params) => StoreAuditResultPage()));
  }
}
