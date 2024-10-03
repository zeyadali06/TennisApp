import 'package:flutter/material.dart';
import 'package:tennis_app/Core/Widgets/CustomButton.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';

class CustomTaskContainer extends StatefulWidget {
  const CustomTaskContainer({super.key, required this.positionEntity, this.onDismissed, required this.isDeafult});

  final PositionEntity positionEntity;
  final Future<void> Function(DismissDirection direction)? onDismissed;
  final bool isDeafult;

  @override
  State<CustomTaskContainer> createState() => _CustomTaskContainerState();
}

class _CustomTaskContainerState extends State<CustomTaskContainer> {
  final double height = 110;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            height: height - 10,
            width: MediaQuery.sizeOf(context).width - 60 - 10,
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.red),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Delete Poistion ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white)),
                Icon(Icons.delete, color: Colors.white),
              ],
            ),
          ),
          Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            onDismissed: widget.onDismissed,
            child: Container(
              height: height - 10,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: const Color(0xff222c48)),
              child: Center(
                child: Card(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  clipBehavior: Clip.hardEdge,
                  elevation: 0,
                  child: ListTile(
                    minVerticalPadding: 0,
                    contentPadding: const EdgeInsets.all(10),
                    tileColor: Colors.transparent,
                    trailing: widget.isDeafult
                        ? CustomButton(
                            fontSize: 14,
                            verticatPadding: 0,
                            horizontalPadding: 0,
                            title: 'Make\nDefault',
                            onPressed: () async {},
                          )
                        : null,
                    title: Text(
                      widget.positionEntity.place,
                      style: const TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
