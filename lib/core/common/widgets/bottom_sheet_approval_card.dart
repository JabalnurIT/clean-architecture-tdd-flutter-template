import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../res/colours.dart';
import '../../res/fonts.dart';
import '../../res/media_res.dart';

class BottomSheetApprovalCard extends StatefulWidget {
  const BottomSheetApprovalCard({
    super.key,
    required this.name,
    required this.shipName,
    required this.type,
    required this.date,
    required this.status,
    required this.route,
  });

  final String name;
  final String shipName;
  final String type;
  final String date;
  final String route;
  final String status;

  @override
  State<BottomSheetApprovalCard> createState() =>
      _BottomSheetApprovalCardState();
}

class _BottomSheetApprovalCardState extends State<BottomSheetApprovalCard> {
  double mediaHeight = 550;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colours.secondaryColour,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      height: mediaHeight,
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 64,
                height: 8,
                decoration: BoxDecoration(
                  color: Colours.primaryColour,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          Positioned(
            top: 45,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      height: 420,
                      width: 330,
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colours.secondaryColour,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.only(top: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 45,
                              ),
                              Center(
                                child: SizedBox(
                                  height: 140,
                                  width: 280,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Colours.primaryColour,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Wrap(children: [
                                      Center(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Menunggu Disetujui',
                                              style: TextStyle(
                                                  color:
                                                      Colours.secondaryColour,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: Fonts.inter),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Align(
                                              child: Text(
                                                'Silahkan tunggu Activity anda disetujui. Cek status Activity anda secara berkala. Jika Activity anda sudah disetujui, maka QR Code akan muncul di halaman utama anda.',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: Fonts.inter,
                                                    color: Colours
                                                        .secondaryColour),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Ringkasan Aktivitas',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: Fonts.inter,
                                          fontWeight: FontWeight.bold,
                                          color: Colours.primaryColour,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                            flex: 5,
                                            child: Text(
                                              'Nama Aktivitas',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: Fonts.inter,
                                                color: Colours.primaryColour,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                ': ${widget.name}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: Fonts.inter,
                                                  color: Colours.primaryColour,
                                                ),
                                              ))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                            flex: 5,
                                            child: Text(
                                              'Nama Kapal',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: Fonts.inter,
                                                color: Colours.primaryColour,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                ': ${widget.shipName}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: Fonts.inter,
                                                  color: Colours.primaryColour,
                                                ),
                                              ))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                            flex: 5,
                                            child: Text(
                                              'Jenis Kegiatan',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: Fonts.inter,
                                                color: Colours.primaryColour,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                ': ${widget.type}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: Fonts.inter,
                                                  color: Colours.primaryColour,
                                                ),
                                              ))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                            flex: 5,
                                            child: Text(
                                              'Rute Kegiatan',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: Fonts.inter,
                                                color: Colours.primaryColour,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                ': ${widget.route}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: Fonts.inter,
                                                  color: Colours.primaryColour,
                                                ),
                                              ))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                            flex: 5,
                                            child: Text(
                                              'Tanggal Dibuat',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: Fonts.inter,
                                                color: Colours.primaryColour,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                ': ${widget.date}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: Fonts.inter,
                                                  color: Colours.primaryColour,
                                                ),
                                              ))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                            flex: 5,
                                            child: Text(
                                              'Status',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: Fonts.inter,
                                                color: Colours.primaryColour,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                ': ${widget.status}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: Fonts.inter,
                                                  color: Colours.primaryColour,
                                                ),
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Transform.scale(
                            scale: 0.65,
                            child: SvgPicture.asset(
                              MediaRes.waitingIcon2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
