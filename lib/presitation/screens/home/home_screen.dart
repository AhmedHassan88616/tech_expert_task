import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tech_experts_task/bussiness_logic/home_cubit/home_cubit.dart';
import 'package:tech_experts_task/data/models/home_model.dart';
import 'package:tech_experts_task/presitation/widgets/role_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      color: Colors.grey[300],
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => RoleCard(
                          role: homeCubit.homeModel!.data![index],
                        ),
                        itemCount: homeCubit.homeModel!.data!.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          height: 10.0,
                        ),
                      ));
                }),
          ),
        );
      },
    );
  }
}
