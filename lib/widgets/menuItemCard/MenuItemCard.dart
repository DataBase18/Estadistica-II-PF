
import 'package:fisicapf/models/models.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MenuItemCard extends StatelessWidget {
  const MenuItemCard({super.key,  required this.item});

  final MenuModel item;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: item.onTab,
      child: Card(
        color: item.backgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height*0.01, horizontal: width*0.04),
          child: Row(
            children: [
              item.imageLottiePath!=null?
              Padding(
                padding:  EdgeInsets.only(right: width*0.05),
                child: Lottie.asset(
                  item.imageLottiePath!,
                  width: 75,
                ),
              ):Container(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                    SizedBox(height: height*0.01,),
                    Text(
                      item.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
