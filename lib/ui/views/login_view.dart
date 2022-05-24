import 'package:admin_dashbord/providers/auth_provider.dart';
import 'package:admin_dashbord/providers/login_form_provider.dart';
import 'package:admin_dashbord/router/router.dart';
import 'package:admin_dashbord/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashbord/ui/buttons/link_text.dart';
import 'package:admin_dashbord/ui/inputs/custom_inputs.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),
      child: Builder(builder: (context) {
        final loginFormProvider =
            Provider.of<LoginFormProvider>(context, listen: false);
        return Container(
          margin: EdgeInsets.only(top: 100),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 370),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: loginFormProvider.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (!EmailValidator.validate(value ?? ''))
                          return 'Email no Válido';
                        return null;
                      },
                      onChanged: (value) => loginFormProvider.email = value,
                      style: TextStyle(color: Colors.white),
                      decoration: CustomInputs.authInputDecoration(
                          hint: "Ingrese email",
                          label: "Email",
                          icon: Icons.email_outlined),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      onFieldSubmitted: (_) =>
                          onFormSubmit(loginFormProvider, authProvider),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Ingrese contraseña';
                        if (value.length < 6)
                          return 'La contraseña debe tener 6 o más caracteres';
                        return null;
                      },
                      onChanged: (value) => loginFormProvider.password = value,
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: CustomInputs.authInputDecoration(
                          hint: "Ingrese password",
                          label: "Password",
                          icon: Icons.lock_outline_rounded),
                    ),
                    SizedBox(height: 10),
                    CustomOutlinedButton(
                      onPressed: () =>
                          onFormSubmit(loginFormProvider, authProvider),
                      text: "Ingresar",
                    ),
                    SizedBox(height: 10),
                    LinkText(
                      text: "Nueva Cuenta",
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Flurorouter.registerRoute);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  void onFormSubmit(
      LoginFormProvider loginFormProvider, AuthProvider authProvider) {
    final isValid = loginFormProvider.validateForm();
    if (isValid)
      authProvider.login(loginFormProvider.email, loginFormProvider.password);
  }
}
