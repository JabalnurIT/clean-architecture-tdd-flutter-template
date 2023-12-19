import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class FileProvider extends ChangeNotifier {
  File? _fileEditEmployee;
  String? _filePathEditEmployee;
  String? _base64EditEmployee;
  String? _uriEditEmployee;

  File? get fileEditEmployee => _fileEditEmployee;
  String? get filePathEditEmployee => _filePathEditEmployee;
  String? get base64EditEmployee => _base64EditEmployee;
  String? get uriEditEmployee => _uriEditEmployee;

  void initFileEditEmployee(File fileEditEmployee) {
    if (_fileEditEmployee != fileEditEmployee) {
      _fileEditEmployee = fileEditEmployee;
      _filePathEditEmployee = fileEditEmployee.path;
      _base64EditEmployee = base64Encode(fileEditEmployee.readAsBytesSync());
      _uriEditEmployee =
          "data:image/${fileEditEmployee.path.split('/').last.split('.').last};base64,${base64Encode(fileEditEmployee.readAsBytesSync())}";
    }
  }

  void initFilePathEditEmployee(String? filePathEditEmployee) {
    if (_filePathEditEmployee != filePathEditEmployee) {
      _filePathEditEmployee = filePathEditEmployee;
    }
  }

  // reset
  void resetEditEmployee() {
    _fileEditEmployee = null;
    _filePathEditEmployee = null;
    _base64EditEmployee = null;
    _uriEditEmployee = null;
  }

  File? _fileAddEmployee;
  String? _filePathAddEmployee;
  String? _base64AddEmployee;
  String? _uriAddEmployee;

  File? get fileAddEmployee => _fileAddEmployee;
  String? get filePathAddEmployee => _filePathAddEmployee;
  String? get base64AddEmployee => _base64AddEmployee;
  String? get uriAddEmployee => _uriAddEmployee;

  void initFileAddEmployee(File fileAddEmployee) {
    if (_fileAddEmployee != fileAddEmployee) {
      _fileAddEmployee = fileAddEmployee;
      _filePathAddEmployee = fileAddEmployee.path;
      _base64AddEmployee = base64Encode(fileAddEmployee.readAsBytesSync());
      _uriAddEmployee =
          "data:image/${fileAddEmployee.path.split('/').last.split('.').last};base64,${base64Encode(fileAddEmployee.readAsBytesSync())}";
    }
  }

  void initFilePathAddEmployee(String? filePathAddEmployee) {
    if (_filePathAddEmployee != filePathAddEmployee) {
      _filePathAddEmployee = filePathAddEmployee;
    }
  }

  // reset
  void resetAddEmployee() {
    _fileAddEmployee = null;
    _filePathAddEmployee = null;
    _base64AddEmployee = null;
    _uriAddEmployee = null;
  }

  File? _fileEditUser;
  String? _filePathEditUser;
  String? _base64EditUser;
  String? _uriEditUser;

  File? get fileEditUser => _fileEditUser;
  String? get filePathEditUser => _filePathEditUser;
  String? get base64EditUser => _base64EditUser;
  String? get uriEditUser => _uriEditUser;

  void initFileEditUser(File fileEditUser) {
    if (_fileEditUser != fileEditUser) {
      _fileEditUser = fileEditUser;
      _filePathEditUser = fileEditUser.path;
      _base64EditUser = base64Encode(fileEditUser.readAsBytesSync());
      _uriEditUser =
          "data:image/${fileEditUser.path.split('/').last.split('.').last};base64,${base64Encode(fileEditUser.readAsBytesSync())}";
    }
  }

  void initFilePathEditUser(String filePathEditUser) {
    if (_filePathEditUser != filePathEditUser) {
      _filePathEditUser = filePathEditUser;
    }
  }

  void resetEditUser() {
    _fileEditUser = null;
    _filePathEditUser = null;
    _base64EditUser = null;
    _uriEditUser = null;
  }

  File? _fileAddItem;
  String? _filePathAddItem;

  File? get fileAddItem => _fileAddItem;
  String? get filePathAddItem => _filePathAddItem;

  void initFileAddItem(File fileItem) {
    if (_fileAddItem != fileItem) {
      _fileAddItem = fileItem;
      _filePathAddItem = fileItem.path;
    }
  }

  void initFilePathAddItem(String filePathItem) {
    if (_filePathAddItem != filePathItem) {
      _filePathAddItem = filePathItem;
    }
  }

  void resetFileAddItem() {
    _fileAddItem = null;
    _filePathAddItem = null;
  }

  File? _fileEditItem;
  String? _filePathEditItem;

  File? get fileEditItem => _fileEditItem;
  String? get filePathEditItem => _filePathEditItem;

  void initFileEditItem(File fileItem) {
    if (_fileEditItem != fileItem) {
      _fileEditItem = fileItem;
      _filePathEditItem = fileItem.path;
    }
  }

  void initFilePathEditItem(String filePathItem) {
    if (_filePathEditItem != filePathItem) {
      _filePathEditItem = filePathItem;
    }
  }

  void resetFileEditItem() {
    _fileEditItem = null;
    _filePathEditItem = null;
  }

  File? _fileAddReport;
  String? _filePathAddReport;
  String? _fileNameAddReport;
  double? _fileSizeAddReport;
  String? _fileUnitSizeAddReport;
  String? _base64AddReport;
  String? _uriAddReport;

  File? get fileAddReport => _fileAddReport;
  String? get filePathAddReport => _filePathAddReport;
  double? get fileSizeAddReport => _fileSizeAddReport;
  String? get fileUnitSizeAddReport => _fileUnitSizeAddReport;
  String? get fileNameAddReport => _fileNameAddReport;
  String? get base64AddReport => _base64AddReport;
  String? get uriAddReport => _uriAddReport;

  void initFileAddReport(File fileAddReport) {
    if (_fileAddReport != fileAddReport) {
      _fileAddReport = fileAddReport;
      _filePathAddReport = fileAddReport.path;
      _fileNameAddReport = fileAddReport.path.split('/').last;
      _fileSizeAddReport = fileAddReport.lengthSync() > 1000000
          ? fileAddReport.lengthSync() / 1000000
          : fileAddReport.lengthSync() > 1000
              ? fileAddReport.lengthSync() / 1000
              : fileAddReport.lengthSync() / 1;
      _fileUnitSizeAddReport = fileAddReport.lengthSync() > 1000000
          ? "MB"
          : fileAddReport.lengthSync() > 1000
              ? "KB"
              : "Bytes";
      _base64AddReport = base64Encode(fileAddReport.readAsBytesSync());
      if (_fileAddReport!.path.split('/').last.split('.').last == "pdf") {
        _uriAddReport =
            "data:application/pdf;base64,${base64Encode(fileAddReport.readAsBytesSync())}";
      } else if (_fileAddReport!.path.split('/').last.split('.').last ==
              "docx" ||
          _fileAddReport!.path.split('/').last.split('.').last == "doc") {
        _uriAddReport =
            "data:application/msword;base64,${base64Encode(fileAddReport.readAsBytesSync())}";
      } else {
        _uriAddReport =
            "data:image/${fileAddReport.path.split('/').last.split('.').last};base64,${base64Encode(fileAddReport.readAsBytesSync())}";
      }
    }
  }

  void initFilePathAddReport(String filePathAddReport) {
    if (_filePathAddReport != filePathAddReport) {
      _filePathAddReport = filePathAddReport;
    }
  }

  void resetFileAddReport() {
    _fileAddReport = null;
    _filePathAddReport = null;
    _fileNameAddReport = null;
    _fileSizeAddReport = null;
    _fileUnitSizeAddReport = null;
    _base64AddReport = null;
    _uriAddReport = null;
  }

  File? _documentationAddReport;
  String? _documentationPathAddReport;
  String? _documentationNameAddReport;
  double? _documentationSizeAddReport;
  String? _documentationUnitSizeAddReport;
  String? _documentationBase64AddReport;
  String? _documentationUriAddReport;

  File? get documentationAddReport => _documentationAddReport;
  String? get documentationPathAddReport => _documentationPathAddReport;
  String? get documentationNameAddReport => _documentationNameAddReport;
  double? get documentationSizeAddReport => _documentationSizeAddReport;
  String? get documentationUnitSizeAddReport => _documentationUnitSizeAddReport;
  String? get documentationBase64AddReport => _documentationBase64AddReport;
  String? get documentationUriAddReport => _documentationUriAddReport;

  void initDocumentationAddReport(File documentationAddReport) {
    if (_documentationAddReport != documentationAddReport) {
      _documentationAddReport = documentationAddReport;
      _documentationPathAddReport = documentationAddReport.path;
      _documentationNameAddReport = documentationAddReport.path.split('/').last;
      _documentationSizeAddReport =
          documentationAddReport.lengthSync() > 1000000
              ? documentationAddReport.lengthSync() / 1000000
              : documentationAddReport.lengthSync() > 1000
                  ? documentationAddReport.lengthSync() / 1000
                  : documentationAddReport.lengthSync() / 1;
      _documentationUnitSizeAddReport =
          documentationAddReport.lengthSync() > 1000000
              ? "MB"
              : documentationAddReport.lengthSync() > 1000
                  ? "KB"
                  : "Bytes";
      _documentationBase64AddReport =
          base64Encode(documentationAddReport.readAsBytesSync());
      _documentationUriAddReport =
          "data:image/${documentationAddReport.path.split('/').last.split('.').last};base64,${base64Encode(documentationAddReport.readAsBytesSync())}";
    }
  }

  void initDocumentationPathAddReport(String documentationPathAddReport) {
    if (_documentationPathAddReport != documentationPathAddReport) {
      _documentationPathAddReport = documentationPathAddReport;
    }
  }

  void resetDocumentationAddReport() {
    _documentationAddReport = null;
    _documentationPathAddReport = null;
    _documentationNameAddReport = null;
    _documentationSizeAddReport = null;
    _documentationBase64AddReport = null;
    _documentationUriAddReport = null;
  }
}
