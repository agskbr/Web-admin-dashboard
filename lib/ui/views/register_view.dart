import 'package:admin_dashbord/providers/auth_provider.dart';
import 'package:admin_dashbord/providers/register_form_provider.dart';
import 'package:admin_dashbord/router/router.dart';
import 'package:admin_dashbord/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashbord/ui/buttons/link_text.dart';
import 'package:admin_dashbord/ui/inputs/custom_inputs.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      child: Builder(builder: (context) {
        final registerFormProvider =
            Provider.of<RegisterFormProvider>(context, listen: false);
        return Container(
          margin: EdgeInsets.only(top: 50),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 370),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: registerFormProvider.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Ingrese nombre válido';
                        return null;
                      },
                      onChanged: (value) => registerFormProvider.name = value,
                      style: TextStyle(color: Colors.white),
                      decoration: CustomInputs.authInputDecoration(
                          hint: "Ingrese nombre",
                          label: "Name",
                          icon: Icons.person),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (!EmailValidator.validate(value ?? ''))
                          return 'Ingrese email válido';
                        return null;
                      },
                      onChanged: (value) => registerFormProvider.email = value,
                      style: TextStyle(color: Colors.white),
                      decoration: CustomInputs.authInputDecoration(
                          hint: "Ingrese email",
                          label: "Email",
                          icon: Icons.email_outlined),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Ingrese contraseña';
                        if (value.length < 6)
                          return 'La contraseña debe tener 6 o más carácteres';
                        return null;
                      },
                      onChanged: (value) =>
                          registerFormProvider.password = value,
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: CustomInputs.authInputDecoration(
                          hint: "Ingrese contraseña",
                          label: "Contraseña",
                          icon: Icons.lock_outline_rounded),
                    ),
                    SizedBox(height: 10),
                    CustomOutlinedButton(
                      onPressed: () {
                        final validForm = registerFormProvider.validateForm();

                        if (!validForm) return;
                        final authProvider =
                            Provider.of<AuthProvider>(context, listen: false);
                        authProvider.register(
                          registerFormProvider.name,
                          registerFormProvider.email,
                          registerFormProvider.password,
                        );
                      },
                      text: "Crear cuenta",
                    ),
                    SizedBox(height: 10),
                    LinkText(
                      text: "Ir al login",
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Flurorouter.loginRoute);
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
}
