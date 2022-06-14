import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/blocs/blocs.dart';
import '/cubits/cubits.dart';
import '/screens/screens.dart';
import '/widgets/widgets.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) {
        print(BlocProvider.of<AuthBloc>(context).state.status);
        return BlocProvider.of<AuthBloc>(context).state.status ==
                AuthStatus.unauthenticated
            ? LoginScreen()
            : HomeScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'DATING NOW',
        hasActions: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _EmailInput(),
            const SizedBox(height: 10),
            _PasswordInput(),
            const SizedBox(height: 10),
            CustomElevatedButton(
              text: 'LOGIN',
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                context.read<LoginCubit>().logInWithCredentials();
              },
              beginColor: Colors.white,
              endColor: Colors.white,
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
              text: 'SIGNUP',
              textColor: Colors.white,
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                OnboardingScreen.routeName,
                ModalRoute.withName('/onboarding'),
              ),
              beginColor: Theme.of(context).accentColor,
              endColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == FormzStatus.submissionInProgress
            ? const CircularProgressIndicator()
            : CustomElevatedButton(
                text: 'LOGIN',
                textColor: Theme.of(context).primaryColor,
                onPressed: () {
                  state.status == FormzStatus.valid
                      ? context.read<LoginCubit>().logInWithCredentials()
                      : ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Check your email and password: ${state.status}'),
                          ),
                        );
                },
                beginColor: Colors.white,
                endColor: Colors.white,
              );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            context.read<LoginCubit>().emailChanged(email);
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: state.email.invalid ? 'The email is invalid.' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: state.password.invalid
                ? 'Password must contain at least 8 characters and at least 1 letter'
                : null,
          ),
          obscureText: true,
        );
      },
    );
  }
}
