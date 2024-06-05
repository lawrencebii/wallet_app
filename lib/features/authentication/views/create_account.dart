import 'package:flutter/material.dart';
import 'package:prime_template/features/authentication/authentication_provider.dart';
import 'package:prime_template/features/authentication/components/custom_btn.dart';
import 'package:prime_template/utils/colors.dart';
import 'package:prime_template/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../navigation/views/navigation.dart';
import '../components/custom_field.dart';
import 'login_page.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<LocalAuthenticationProvider>().setErrorMessage(null);
      context.read<LocalAuthenticationProvider>().setIsloading(false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var spaceY = SizedBox(
      height: pH(20, context),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<LocalAuthenticationProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    spaceY,
                    Text(
                      "Create an account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 34,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Invest and double your income now",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xff4F4F4F),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ...[
                      spaceY,
                      spaceY,
                      if (provider.errorMessage != null)
                        Text(
                          provider.errorMessage.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.redAccent.withOpacity(0.5),
                          ),
                        ),
                      spaceY,
                      spaceY
                    ],
                    TextFormFieldCustom(
                      keyboardType: TextInputType.text,
                      backgroundColor: ColorsConstants.profileInputbackround
                          .withOpacity(0.1),
                      width: pW(340, context),
                      height: pH(70, context),
                      prefixIcon: null,
                      hintText: "Full Name.",
                      controller: provider.nameController,
                      validator: (value) {
                        return value!.isEmpty
                            ? "Please enter the full name"
                            : null;
                      },
                      onChanged: (text) {
                        setState(() {
                          // name = text;
                        });
                      },
                    ),
                    SizedBox(
                      height: pH(20, context),
                    ),
                    TextFormFieldCustom(
                      keyboardType: TextInputType.text,
                      backgroundColor: ColorsConstants.profileInputbackround
                          .withOpacity(0.1),
                      width: pW(340, context),
                      height: pH(70, context),
                      prefixIcon: null,
                      hintText: "Email address",
                      controller: provider.emailController,
                      validator: (value) {
                        return value!.isEmpty
                            ? "Please enter the email address"
                            : null;
                      },
                      onChanged: (text) {
                        setState(() {
                          // name = text;
                        });
                      },
                    ),
                    SizedBox(
                      height: pH(20, context),
                    ),
                    TextFormFieldCustomPass(
                      keyboardType: TextInputType.text,
                      backgroundColor: ColorsConstants.profileInputbackround
                          .withOpacity(0.1),
                      width: pW(340, context),
                      height: pH(70, context),
                      suffixIcon: Icon(Icons.visibility),
                      hintText: "Password",
                      obscuringCharacter: '*',
                      obscureText: true,
                      controller: provider.passwordController,
                      validator: (value) {
                        return value!.isEmpty
                            ? "Please enter the password"
                            : null;
                      },
                      onChanged: (text) {
                        setState(() {
                          // name = text;
                        });
                      },
                    ),
                    SizedBox(
                      height: pH(40, context),
                    ),
                    provider.loading
                        ? CircularProgressIndicator()
                        : CustomButton(
                            label: "Create Account",
                            pressed: () {
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<LocalAuthenticationProvider>()
                                    .signUp(context);
                              }
                            },
                          ),
                    SizedBox(
                      height: pH(20, context),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Already have an account?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
