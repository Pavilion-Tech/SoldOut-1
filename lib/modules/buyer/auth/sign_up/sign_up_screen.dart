import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/auth/auth_cubit/auth_cubit.dart';
import 'package:soldout/modules/buyer/auth/auth_cubit/auth_state.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../widgets/sign_widget.dart';
import '../verification/verification_scren.dart';

class SignUpScreen extends StatelessWidget {

  var formKey =GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if(state is SignSuccessState)navigateTo(context,VerificationScreen());
        if(state is SignErrorState)showToast(msg:state.msg,toastState: false);
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: myAppBar(
                  context: context,
                  title: tr('sign_up'),
                  isArrowBack: true,
                ),
              ),
              SignWidget(
                column: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: size!.height * .05,),
                      defaultTextField(
                        hint: tr('full_name'),
                        controller: nameController,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Name Must Be Empty';
                          }
                        }
                      ),
                      SizedBox(height: size!.height * .01,),
                      defaultTextField(
                          hint: tr('phone'),
                          controller: phoneController,
                          type: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Phone Must Be Empty';
                            }
                          }
                      ),

                      SizedBox(height: size!.height * .01,),
                      state is SignLoadingState
                          ? const CircularProgressIndicator()
                          : defaultButton(
                        text: tr('sign_up'),
                        onTap: () {
                          FocusManager.instance.primaryFocus!.unfocus();
                          if(formKey.currentState!.validate())
                          {
                            AuthCubit.get(context).sign(
                                name: nameController.text,
                                phone: phoneController.text
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


}