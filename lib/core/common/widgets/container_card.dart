import 'package:flutter/material.dart';
import '../../res/colours.dart';

class ContainerCard extends StatefulWidget {
  const ContainerCard({
    super.key,
    this.backgroundColor = Colours.secondaryColour,
    required this.children,
    this.header,
    this.mediaHeight,
    this.headerHeight,
    this.padding,
  });

  final Color backgroundColor;
  final List<Widget> children;
  final Widget? header;
  final double? headerHeight;
  final double? mediaHeight;
  final double? padding;

  @override
  State<ContainerCard> createState() => _ContainerCardState();
}

class _ContainerCardState extends State<ContainerCard> {
  double mediaHeight = 550;
  @override
  Widget build(BuildContext context) {
    if (mediaHeight > 550) {
      setState(() {
        mediaHeight = 550;
      });
    }
    return Align(
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: (widget.mediaHeight != null)
                      ? MediaQuery.of(context).size.height * widget.mediaHeight!
                      : mediaHeight,
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    margin: widget.headerHeight != null
                        ? EdgeInsets.only(top: widget.headerHeight!)
                        : null,
                    child: ListView(
                      shrinkWrap: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: widget.padding ?? 0),
                      children: widget.children,
                    ),
                  ),
                ),
                if (widget.header != null)
                  GestureDetector(
                    onVerticalDragUpdate: (details) {
                      if (mediaHeight <
                          MediaQuery.of(context).size.height * 0.2) {
                        setState(() {
                          mediaHeight += 0.1;
                        });
                      } else {
                        setState(() {
                          mediaHeight += details.delta.dy * (-0.8);
                        });
                      }
                    },
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: widget.header,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
