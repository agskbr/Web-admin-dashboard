import 'package:admin_dashbord/models/user.dart';
import 'package:admin_dashbord/providers/providers.dart';
import 'package:admin_dashbord/router/router.dart';
import 'package:admin_dashbord/services/navigation-service.dart';
import 'package:admin_dashbord/services/notification_service.dart';
import 'package:admin_dashbord/ui/cards/white_card.dart';
import 'package:admin_dashbord/ui/inputs/custom_inputs.dart';
import 'package:admin_dashbord/ui/labels/custom_labels.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserView extends StatefulWidget {
  final String uid;

  const UserView({Key? key, required this.uid}) : super(key: key);

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  Usuario? user;

  @override
  void initState() {
    super.initState();
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final userFormProvider =
        Provider.of<UserFormProvider>(context, listen: false);

    usersProvider.getUserById(widget.uid).then((userDB) {
      if (userDB != null) {
        userFormProvider.user = userDB;
        userFormProvider.formKey = GlobalKey<FormState>();
        setState(() {
          this.user = userDB;
        });
      } else {
        NavigationService.replaceTo(Flurorouter.usersRoute);
      }
    });
  }

  @override
  void dispose() {
    this.user = null;
    Provider.of<UserFormProvider>(context).user = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text(
            "User View",
            style: CustomLabels.h1,
          ),
          SizedBox(height: 10),
          if (user == null)
            WhiteCard(
              child: Container(
                alignment: Alignment.center,
                height: 300,
                child: CircularProgressIndicator(),
              ),
            ),
          if (user != null) _UserViewBody()
        ],
      ),
    );
  }
}

class _UserViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        columnWidths: {
          0: FixedColumnWidth(250),
        },
        children: [
          TableRow(
            children: [
              _AvatarContainer(),
              _UserViewForm(),
            ],
          ),
        ],
      ),
    );
  }
}

class _UserViewForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;
    return WhiteCard(
      title: "Informacion general ${user.correo}",
      child: Form(
        key: userFormProvider.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) =>
                  userFormProvider.copyUserWith(nombre: value),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Ingrese un nombre';
                if (value.length <= 2) return 'El nombre es muy corto';
                return null;
              },
              initialValue: user.nombre,
              decoration: CustomInputs.formInputDecoration(
                hint: "Nombre del usuario",
                label: "Nombre",
                icon: Icons.supervised_user_circle_outlined,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              initialValue: user.correo,
              decoration: CustomInputs.formInputDecoration(
                hint: "Correo del usuario",
                label: "Correo",
                icon: Icons.mark_email_read_outlined,
              ),
              validator: (value) {
                if (!EmailValidator.validate(value ?? ''))
                  return 'Email no valido';
                return null;
              },
            ),
            SizedBox(height: 20),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 100),
              child: ElevatedButton(
                onPressed: () async {
                  final saved = await userFormProvider.updateUser();

                  if (saved) {
                    NotificationService.showSnackbarSuccesful(
                        'Usuario actualizado');
                    Provider.of<UsersProvider>(context, listen: false)
                        .refreshUsers(user);
                  } else {
                    NotificationService.showSnackbarError('No se pudo guardar');
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: Row(
                  children: [
                    Icon(Icons.save_outlined, size: 20),
                    Text("Guardar"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = Provider.of<UserFormProvider>(context).user!;

    final image = (user.img == null)
        ? Image(
            image: AssetImage('no-image.jpg'),
          )
        : FadeInImage.assetNetwork(placeholder: 'loader.gif', image: user.img!);
    return WhiteCard(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Profile", style: CustomLabels.h2),
            SizedBox(height: 20),
            Container(
              child: Stack(
                children: [
                  ClipOval(child: image),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.white, width: 5)),
                      child: FloatingActionButton(
                        child: Icon(Icons.camera_alt_outlined, size: 20),
                        backgroundColor: Colors.indigo,
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            allowedExtensions: ['jpg', 'jpeg', 'png'],
                            type: FileType.custom,
                            allowMultiple: false,
                          );

                          if (result != null) {
                            /* PlatformFile file = result.files.first; */
                            NotificationService.showImageLoading(context);

                            final newUser = await userFormProvider.uploadImage(
                                '/uploads/usuarios/${user.uid}',
                                result.files.first.bytes!);

                            Provider.of<UsersProvider>(context, listen: false)
                                .refreshUsers(newUser);

                            Navigator.pop(context);
                          } else {}
                        },
                      ),
                    ),
                  ),
                ],
              ),
              width: 150,
              height: 160,
            ),
            SizedBox(height: 20),
            Text(
              userFormProvider.user!.nombre,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      width: 250,
    );
  }
}
