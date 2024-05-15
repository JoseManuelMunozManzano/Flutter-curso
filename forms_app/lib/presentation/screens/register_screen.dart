import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/register/register_cubit.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Usuario'),
      ),

      // Envolvemos en un BlocProvider para poder usar nuestro Cubit.
      body: BlocProvider(
        create: (context) =>  RegisterCubit(),
        child: const _RegisterView(),
      )
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    // El Widget TextFormField se relaciona con un formulario, mientras que el TextField no.
    // Cuando colocamos este Widget en pantalla, tenemos que tener en cuenta el teclado y la posición del Widget.
    // Si vamos a colocar un input muy abajo, podemos trabajar con el Widget SafeArea, que se va a asegurar
    // de mostrar ese Widget sin estorbos, ya sea el notch, controles de movimiento o lo que sea.
    // Pero esto tiene otro problema serio, porque el Widget Column es inflexible, es decir, que si aparece el teclado
    // y empuja para arriba el input, puede que choque contra otro Widget, y esto va a romper la app.
    // Es por esto que, salvo que el input esté muy arriba, se recomienda envolver todo en un Widget que tenga algún
    // tipo de scroll, ya sea un ListView o un Sliver, CustomChildScrollView...
    // Pero idealmente, vamos a querer envolver el Widget Column en un SingleChildScrollView, lo que cambia la funcionalidad,
    // pero nos permite hacer scroll.
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              FlutterLogo(size: 100,),

              _RegisterForm(),

              // Espacio de gracia para que el usuario pueda hacer un poco de scroll.
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Aunque ya tenemos el estado fuera del componente, por ahora vamos a dejar este Widget como un StatefulWidget.
class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {

  // Este GlobalKey nos permite enlazar con el key del Widget Form. Así obtenemos el control
  // del formulario basado en este key (_formKey)
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    // Obtenemos la referencia al Cubit.
    // Recordar que usando el watch(), cada vez que el estado cambia, va a volver a disparar
    // el redibujo de este build.
    final registerCubit = context.watch<RegisterCubit>();

    return Form(
      key: _formKey,
      child: Column(
        children: [

          CustomTextFormField(
            label: 'Nombre de usuario',
            // No usamos setState porque no queremos que se redibuje cuando el value cambia.
            onChanged: (value) {
              registerCubit.usernameChanged(value);
              // Cada vez que el usuario escribe algo, vemos si valida cada uno de los campos.
              // Se acabará haciendo de otra forma.
              _formKey.currentState?.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              if (value.length < 6) return 'Más de 6 letras';
              return null;
            },
          ),

          const SizedBox(height: 10),

          CustomTextFormField(
            label: 'Correo electrónico',
            onChanged: (value) {
              registerCubit.emailChanged(value);
              _formKey.currentState?.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';

              final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

              if (!emailRegExp.hasMatch(value)) return 'No tiene formato de correo';

              return null;
            },
          ),

          const SizedBox(height: 10),

          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: (value) {
              registerCubit.passwordChanged(value);
              _formKey.currentState?.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              if (value.length < 6) return 'Más de 6 letras';
              return null;
            },
          ),

          const SizedBox(height: 20),

          FilledButton.tonalIcon(
            onPressed: () {

              // Aquí ejecutamos los distintos validator de los CustomTextFormField.
              // Esto lo acabaremos borrando porque lo acabará haciendo mi estado.
              //
              // final isValid = _formKey.currentState!.validate();
              // if (!isValid) return;

              // Cuando todos los validators son correctos, se obtiene el valor.
              // Aquí podría llamarse un gestor de estado, un provider... que tomara la data
              // y mandara llamar la función que hace el POST.
              registerCubit.onSubmit();
            },
            icon: const Icon(Icons.save),
            label: const Text('Crear usuario'),
          ),
        ],
      )
    );
  }
}
