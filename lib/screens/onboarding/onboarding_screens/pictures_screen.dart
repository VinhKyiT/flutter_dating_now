import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '/blocs/blocs.dart';
import '/screens/onboarding/widgets/widgets.dart';

class PicturesTab extends StatelessWidget {
  const PicturesTab({Key? key}) : super(key: key);

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
          var images = state.user.imageUrls;
          var imageCount = images.length;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextHeader(text: 'Add 2 or More Pictures'),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 350,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.66,
                        ),
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int index) {
                          return (imageCount > index)
                              ? CustomImageContainer(imageUrl: images[index])
                              : CustomImageContainer();
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    StepProgressIndicator(
                      totalSteps: 6,
                      currentStep: 4,
                      selectedColor: Theme.of(context).primaryColor,
                      unselectedColor: Theme.of(context).backgroundColor,
                    ),
                    SizedBox(height: 10),
                    CustomButton(
                      text: 'NEXT STEP',
                      onPressed: () {
                        if (imageCount >= 2) {
                          context
                              .read<OnboardingBloc>()
                              .add(ContinueOnboarding(user: state.user));
                        } else {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please add at least 2 pictures'),
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
        } else {
          return Text('Something went wrong.');
        }
      },
    );
  }
}
