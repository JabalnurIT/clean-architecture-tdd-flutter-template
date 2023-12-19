import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/app/providers/file_provider.dart';
import '../../../../core/common/widgets/container_card.dart';
import '../../../../core/common/widgets/gradient_background.dart';
import '../../../../core/res/colours.dart';
import '../../../../core/res/fonts.dart';
import '../../../../core/res/media_res.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class EditPhotoProfileScreen extends StatefulWidget {
  const EditPhotoProfileScreen({
    super.key,
    required this.photoController,
  });

  final TextEditingController photoController;

  static const routeName = '/edit-user-photo';

  @override
  State<EditPhotoProfileScreen> createState() => EditPhotoProfileScreenState();
}

class EditPhotoProfileScreenState extends State<EditPhotoProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // debugPrint("state: $state");
        if (state is PhotoProfileAdded) {
          if (state.photo != null) {
            context.read<FileProvider>().initFileEditUser(state.photo);
            context.read<FileProvider>().initFilePathEditUser(state.photo.path);
            widget.photoController.text = state.photo.path;
          } else {
            widget.photoController.text = "";
            context.read<FileProvider>().resetEditUser();
          }
          final navigator = Navigator.of(context);
          if (navigator.canPop()) {
            navigator.pop();
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colours.primaryColour,
            leading: IconButton(
              color: Colours.secondaryColour,
              iconSize: 30,
              icon: Icon(
                Theme.of(context).platform == TargetPlatform.iOS
                    ? Icons.arrow_back_ios_new
                    : Icons.arrow_back,
              ),
              onPressed: () {
                final navigator = Navigator.of(context);
                if (navigator.canPop()) {
                  navigator.pop();
                }
              },
            ),
          ),
          backgroundColor: Colors.transparent,
          body: GradientBackground(
            image: MediaRes.colorBackground,
            child: ContainerCard(
              mediaHeight: 0.8,
              headerHeight: 52,
              header: Consumer<FileProvider>(
                builder: (_, fileProvider, __) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: fileProvider.fileEditUser != null
                            ? Image.file(
                                fileProvider.fileEditUser!,
                                width: 104,
                                height: 104,
                                fit: BoxFit.cover,
                              )
                            : widget.photoController.text != ""
                                ? Image.network(
                                    widget.photoController.text,
                                    width: 104,
                                    height: 104,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 104,
                                    height: 104,
                                    padding: const EdgeInsets.only(
                                      left: 24,
                                      top: 24,
                                      right: 24,
                                      bottom: 24,
                                    ),
                                    color: Colours.profileBackgroundColour,
                                    child: SvgPicture.asset(
                                      MediaRes.profileIcon,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                      ),
                    ],
                  );
                },
              ),
              padding: 10,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Tambah Foto Profil',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colours.primaryColour,
                          fontFamily: Fonts.inter,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        debugPrint("Camera Clicked");
                        context.read<AuthBloc>().add(
                              const AddPhotoEvent(type: 'camera'),
                            );
                      },
                      child: Container(
                        width: 220,
                        height: 96,
                        decoration: BoxDecoration(
                          color: Colours.primaryColour,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              decoration: BoxDecoration(
                                color: Colours.secondaryColour,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colours.primaryColour,
                                size: 40,
                              ),
                            ),
                            const SizedBox(
                              width: 100,
                              child: Text(
                                'Kamera',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  fontFamily: Fonts.inter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().add(
                              const AddPhotoEvent(type: 'galery'),
                            );
                      },
                      child: Container(
                        width: 220,
                        height: 96,
                        decoration: BoxDecoration(
                          color: Colours.primaryColour,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              decoration: BoxDecoration(
                                color: Colours.secondaryColour,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Icon(
                                Icons.image,
                                color: Colours.primaryColour,
                                size: 40,
                              ),
                            ),
                            const SizedBox(
                              width: 100,
                              child: Text(
                                'Galeri',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  fontFamily: Fonts.inter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().add(
                              const AddPhotoEvent(type: 'remove'),
                            );
                      },
                      child: Container(
                        width: 220,
                        height: 96,
                        decoration: BoxDecoration(
                          color: Colours.primaryColour,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              decoration: BoxDecoration(
                                color: Colours.secondaryColour,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Colours.primaryColour,
                                size: 40,
                              ),
                            ),
                            const SizedBox(
                              width: 100,
                              child: Text(
                                'Tanpa Foto',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  fontFamily: Fonts.inter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
