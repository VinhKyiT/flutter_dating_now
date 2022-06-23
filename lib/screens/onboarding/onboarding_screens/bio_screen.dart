import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '/screens/onboarding/widgets/widgets.dart';
import '/blocs/blocs.dart';

class BioTab extends StatelessWidget {
  const BioTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is OnboardingLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextHeader(text: 'Describe Yourself'),
                    CustomTextField(
                      hint: 'ENTER YOUR BIO',
                      onChanged: (value) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user: state.user.copyWith(bio: value),
                              ),
                            );
                      },
                    ),
                    SizedBox(height: 50),
                    CustomTextHeader(text: 'What do you do?'),
                    CustomTextField(
                      hint: 'ENTER YOUR JOB TITLE',
                      onChanged: (value) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user: state.user.copyWith(jobTitle: value),
                              ),
                            );
                      },
                    ),
                    SizedBox(height: 50),
                    CustomTextHeader(text: 'What Do You Like?'),
                    Row(
                      children: [
                        InkWell(
                          child: CustomTextContainer(text: 'MUSIC'),
                          onTap: () {
                            context.read<OnboardingBloc>().add(
                                  UpdateUser(
                                    user: state.user.copyWith(
                                      interests: [
                                        ...state.user.interests,
                                        'MUSIC',
                                      ],
                                    ),
                                  ),
                                );
                          },
                        ),
                        InkWell(
                          child: CustomTextContainer(text: 'ECONOMICS'),
                          onTap: () {
                            context.read<OnboardingBloc>().add(
                                  UpdateUser(
                                    user: state.user.copyWith(
                                      interests: [
                                        ...state.user.interests,
                                        'ECONOMICS',
                                      ],
                                    ),
                                  ),
                                );
                          },
                        ),
                        InkWell(
                          child: CustomTextContainer(text: 'READING'),
                          onTap: () {
                            context.read<OnboardingBloc>().add(
                                  UpdateUser(
                                    user: state.user.copyWith(
                                      interests: [
                                        ...state.user.interests,
                                        'READING',
                                      ],
                                    ),
                                  ),
                                );
                          },
                        ),
                        InkWell(
                          child: CustomTextContainer(text: 'ART'),
                          onTap: () {
                            context.read<OnboardingBloc>().add(
                                  UpdateUser(
                                    user: state.user.copyWith(
                                      interests: [
                                        ...state.user.interests,
                                        'ART',
                                      ],
                                    ),
                                  ),
                                );
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          child: CustomTextContainer(text: 'SINGING'),
                          onTap: () {
                            context.read<OnboardingBloc>().add(
                                  UpdateUser(
                                    user: state.user.copyWith(
                                      interests: [
                                        ...state.user.interests,
                                        'SINGING',
                                      ],
                                    ),
                                  ),
                                );
                          },
                        ),
                        InkWell(
                          child: CustomTextContainer(text: 'DRINK'),
                          onTap: () {
                            context.read<OnboardingBloc>().add(
                                  UpdateUser(
                                    user: state.user.copyWith(
                                      interests: [
                                        ...state.user.interests,
                                        'DRINK',
                                      ],
                                    ),
                                  ),
                                );
                          },
                        ),
                        InkWell(
                          child: CustomTextContainer(text: 'SOCCER'),
                          onTap: () {
                            context.read<OnboardingBloc>().add(
                                  UpdateUser(
                                    user: state.user.copyWith(
                                      interests: [
                                        ...state.user.interests,
                                        'SOCCER',
                                      ],
                                    ),
                                  ),
                                );
                          },
                        ),
                        InkWell(
                          child: CustomTextContainer(text: 'MOVIES'),
                          onTap: () {
                            context.read<OnboardingBloc>().add(
                                  UpdateUser(
                                    user: state.user.copyWith(
                                      interests: [
                                        ...state.user.interests,
                                        'MOVIES',
                                      ],
                                    ),
                                  ),
                                );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    StepProgressIndicator(
                      totalSteps: 6,
                      currentStep: 5,
                      selectedColor: Theme.of(context).primaryColor,
                      unselectedColor: Theme.of(context).backgroundColor,
                    ),
                    SizedBox(height: 10),
                    CustomButton(
                      text: 'NEXT STEP',
                      onPressed: () {
                        context
                            .read<OnboardingBloc>()
                            .add(ContinueOnboarding(user: state.user));
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Text('Something went wrong.');
        }
      },
    );
  }
}
