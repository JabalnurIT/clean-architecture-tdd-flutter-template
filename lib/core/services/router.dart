import 'package:clean_architecture_tdd_flutter_template/core/extensions/context_extensions.dart';
import 'package:clean_architecture_tdd_flutter_template/core/services/injection_container.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/data/models/user_model.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/presentation/views/sign_in_screen.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/presentation/views/sign_up_screen.dart';
import 'package:clean_architecture_tdd_flutter_template/src/dashboard/presentation/views/dashboard_screen.dart';
import 'package:clean_architecture_tdd_flutter_template/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import '../../src/on_boarding/presentation/views/on_boarding_screen.dart';
import '../common/views/page_under_construction.dart';

part 'router.main.dart';
