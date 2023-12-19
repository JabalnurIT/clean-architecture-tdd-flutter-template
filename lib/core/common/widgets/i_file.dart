import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../res/colours.dart';
import '../../res/fonts.dart';
import '../../res/media_res.dart';

class IFile extends StatelessWidget {
  const IFile({
    super.key,
    this.filled = false,
    required this.onPressed,
    this.fileName,
    this.fileSize,
    this.unitSize,
  });
  final bool filled;
  final String? fileName;
  final double? fileSize;
  final String? unitSize;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: screenWidth * 0.89,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  filled
                      ? Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                MediaRes.acceptIcon,
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Berhasil Unggah",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colours.primaryColour,
                                  fontFamily: Fonts.inter,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            "Belum ada Unggahan",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colours.primaryColour,
                              fontFamily: Fonts.inter,
                            ),
                          ),
                        ),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colours.primaryColour),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      fixedSize: MaterialStateProperty.all(
                          Size(screenWidth * 0.4, 60)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                    ),
                    onPressed: onPressed,
                    icon: SvgPicture.asset(
                      MediaRes.uploadIcon,
                      height: 18,
                    ),
                    label: const Text(
                      "Unggah",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colours.secondaryColour,
                        fontFamily: Fonts.inter,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        filled
            ? Text(
                '$fileName (${fileSize!.toStringAsFixed(2)} $unitSize)',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colours.primaryColour,
                  fontFamily: Fonts.inter,
                ),
              )
            : const Text(
                "Nama dokumen",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colours.primaryColour,
                  fontFamily: Fonts.inter,
                ),
              ),
      ],
    );
  }
}
