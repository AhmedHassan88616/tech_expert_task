import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tech_experts_task/bussiness_logic/home_cubit/home_cubit.dart';
import 'package:tech_experts_task/data/models/home_model.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final homeCubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            centerTitle: true,
          ),
          body: BuildCondition(
            condition: state is FailedHomeData,
            builder: (_) => Center(
                child: Text(
              'There is a problem!',
              style: Theme.of(context).textTheme.bodyText1,
            )),
            fallback: (context) => BuildCondition(
                condition: state is LoadingHomeData,
                builder: (_) => Center(child: CircularProgressIndicator()),
                fallback: (context) {
                  return Container(
                      color: Colors.grey[400],
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              (orientation == Orientation.portrait) ? 2 : 3,
                          childAspectRatio:
                              (orientation == Orientation.portrait)
                                  ? 1.285 / 2
                                  : 1.7/2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 8.0,
                        ),
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => _buildRoleItem(
                            context, homeCubit.homeModel!.data![index]),
                        itemCount: homeCubit.homeModel!.data!.length,
                      ));
                }),
          ),
        );
      },
    );
  }

  _buildRoleItem(context, Role role) {
    return Container(
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
                height: 180.0,
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
                alignment: Alignment.center,
                color: Colors.black.withOpacity(0.5),
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
            child: Html(
              data: role.statement,
            ),
          ),
        ],
      ),
    );
  }
}
