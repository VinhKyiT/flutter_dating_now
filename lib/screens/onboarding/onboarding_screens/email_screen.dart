import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../blocs/blocs.dart';
import '../../../models/models.dart';
import '/cubits/cubits.dart';
import '/screens/onboarding/widgets/widgets.dart';
import 'package:formz/formz.dart';

class EmailTab extends StatelessWidget {
  const EmailTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 50,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextHeader(text: 'What\'s Your Email Address?'),
              BlocBuilder<SignupCubit, SignupState>(
                buildWhen: (previous, current) =>
                    previous.email != current.email,
                builder: (context, state) {
                  return CustomTextField(
                    hint: 'ENTER YOUR EMAIL',
                    errorText:
                        state.email.invalid ? 'The email is invalid.' : null,
                    onChanged: (value) {
                      context.read<SignupCubit>().emailChanged(value);
                    },
                  );
                },
              ),
              SizedBox(height: 100),
              CustomTextHeader(text: 'Choose a Password'),
              BlocBuilder<SignupCubit, SignupState>(
                buildWhen: (previous, current) =>
                    previous.password != current.password,
                builder: (context, state) {
                  return CustomTextField(
                    hint: 'ENTER YOUR PASSWORD',
                    errorText: state.password.invalid
                        ? 'Password must contain at least 8 characters and 1 letter'
                        : null,
                    onChanged: (value) {
                      context.read<SignupCubit>().passwordChanged(value);
                    },
                    isPassword: true,
                  );
                },
              ),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 1,
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).backgroundColor,
              ),
              SizedBox(height: 10),
              CustomButton(
                text: 'NEXT STEP',
                onPressed: () async {
                  if (BlocProvider.of<SignupCubit>(context).state.status ==
                      FormzStatus.valid) {
                    await context.read<SignupCubit>().signUpWithCredentials();
                    context.read<OnboardingBloc>().add(
                          ContinueOnboarding(
                            isSignup: true,
                            user: User.empty.copyWith(
                              id: context.read<SignupCubit>().state.user!.uid,
                            ),
                          ),
                        );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Check your email and password'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
