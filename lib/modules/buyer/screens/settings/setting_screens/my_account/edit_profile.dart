import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/buyer_layout/buy_layout_screen.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/modules/buyer/auth/auth_cubit/auth_cubit.dart';
import 'package:soldout/modules/buyer/auth/auth_cubit/auth_state.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../../widgets/my_container.dart';
import '../../../../widgets/settings/settings_screens_widgets/edit_profile/edit_profile_widget.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          myAppBar(
              context: context,
              title: tr('edit_profile'),
              isArrowBack: true,
              isLastIcon: true,
              lastIcon: Icons.shopping_cart,
              lastButtonTap: () {
                BuyerCubit.get(context).changeIndex(2);
                navigateAndFinish(context, BuyerLayout());
              }
          ),
          MyContainer(
              BlocConsumer<AuthCubit, AuthStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  var cubit = AuthCubit.get(context);
                  return ConditionalBuilder(
                    builder: (context) => EditProfileWidget(),
                    fallback: (context) =>
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const[
                            CircularProgressIndicator()
                          ],
                        ),
                    condition: cubit.getProfileModel != null,
                  );
                },
              ),
              noSize: false
          ),
        ],
      ),
    );
  }
}
