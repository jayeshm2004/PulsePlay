import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/view/widgets/custom_field.dart';
import 'package:client/features/auth/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewModelProvider).isLoading == true;

    ref.listen(authViewModelProvider, (_, next) {
      next.when(
        data: (data) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const LoginPage()),
          // );
        },
        error: (error, st) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
        loading: () {},
      );
    });
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomField(hintText: 'Email', controller: emailcontroller),

                    const SizedBox(height: 15),

                    CustomField(
                      hintText: 'Password',
                      controller: passwordcontroller,
                      isObscureText: true,
                    ),

                    const SizedBox(height: 15),
                    AuthGradientButton(
                      buttonText: 'Sign In',
                      onTap: () async {
                        final res = await AuthRemoteRepository().login(
                          email: emailcontroller.text,
                          password: passwordcontroller.text,
                        );

                        final val = switch (res) {
                          Left(value: final l) => l,
                          Right(value: final r) => r.toString(),
                        };
                        print(val);
                      },
                    ),

                    const SizedBox(height: 15),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupPage(),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don't Have an Account?",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
