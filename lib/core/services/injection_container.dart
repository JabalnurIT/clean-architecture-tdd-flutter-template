import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../src/auth/data/datasources/auth_remote_data_source.dart';
import '../../src/auth/data/repositories/auth_repository_impl.dart';
import '../../src/auth/domain/repositories/auth_repository.dart';
import '../../src/auth/domain/usecases/add_photo.dart';
import '../../src/auth/domain/usecases/sign_in.dart';
import '../../src/auth/domain/usecases/sign_in_with_credential.dart';
import '../../src/auth/domain/usecases/sign_out.dart';
import '../../src/auth/domain/usecases/update_user.dart';
import '../../src/auth/presentation/bloc/auth_bloc.dart';
import '../services/api.dart';

part 'injection_container.main.dart';
