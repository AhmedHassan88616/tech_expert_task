import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tech_experts_task/data/models/home_model.dart';

class RoleCard extends StatelessWidget {
final Role role;

  const RoleCard({Key? key,required this.role}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image(
                image: NetworkImage(
                  'https://img.freepik.com/free-photo/numbers-2022-gray-table-top-view-with-gifts-holiday-decor-one-side-medical-equipment_340805-490.jpg?size=338&ext=jpg',
                ),
                width: double.infinity,
                height: 220.0,
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
                alignment: Alignment.center,
                color: Colors.black.withOpacity(0.6),
                child: Text(
                  '${role.title}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Html(
                data: role.statement,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
