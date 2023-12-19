import '../utils/constanst.dart';

class API {
  final APIAuth auth;
  final APIEmployee employee;
  final APIAgent agent;
  final APIActivity activity;
  final APIItems items;
  final APIReport report;

  API({String? id})
      : auth = APIAuth(id: id),
        employee = APIEmployee(id: id),
        agent = APIAgent(id: id),
        activity = APIActivity(id: id),
        items = APIItems(id: id),
        report = APIReport(id: id);

  String get baseUrl => kBaseUrl;
}

class APIAuth {
  const APIAuth({this.id});

  final String? id;

  String get signIn => "$kHost/login";
  String get signInWithCredential => "$kHost/login-with-credential";
  String get logout => "$kHost/logout";
  String get profile => "$kHost/profile";
}

class APIEmployee {
  const APIEmployee({this.id});
  final String? id;

  String get employees => "$kHost/employees";
  String get employeeDetail => "$employees/$id";
  String get employeeDivision => "$kHost/bagian";
}

class APIAgent {
  const APIAgent({this.id});
  final String? id;

  String get activities => "$kHost/activities/ship-chandler";
  String get activityDetail => "$activities/$id";
}

class APIActivity {
  const APIActivity({this.id});
  final String? id;

  String get activities => "$kHost/activities/security";
  String get activityDetail => "$activities/$id";
  String get scanQRCode => "$activityDetail/scan-qr-code";
}

class APIItems {
  const APIItems({this.id});
  final String? id;

  String get items => "$kHost/goods";
  String get detailItem => "$items/$id";
}

class APIReport {
  const APIReport({this.id});
  final String? id;

  String get report => "$kHost/report";
  String get detailReport => "$report/$id";
}
