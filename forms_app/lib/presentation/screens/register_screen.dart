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

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {

    // Obtenemos la referencia al Cubit.
    // Recordar que usando el watch(), cada vez que el estado cambia, va a volver a disparar
    // el redibujo de este build.
    final registerCubit = context.watch<RegisterCubit>();
    final username = registerCubit.state.username;
    final password = registerCubit.state.password;

    return Form(
      child: Column(
        children: [

          CustomTextFormField(
            label: 'Nombre de usuario',
            // No usamos setState porque no queremos que se redibuje cuando el value cambia.
            onChanged: registerCubit.usernameChanged,
            // Si no indicamos el username.isPure, el problema es que valida antes de empezar a informar nada.
            // También podemos tener un estado, en el enum FormStatus, por ejemplo never_posted que indique
            // que se ha posteado una vez (el estado cambia en onSubmit()) y entonces empezar a indicar errores.
            // También vemos en el funcionamiento actual que, si pulsamos Crear usuario sin tocar nada,
            // no aparecen errores. El motivo es que no ha cambiado el estado.
            // Necesitamos hacer un procedimiento o algo en el lado del Cubit que indique que el usarname ya
            // no es pure.
            errorMessage: username.errorMessage,
          ),

          const SizedBox(height: 10),

          CustomTextFormField(
            label: 'Correo electrónico',
            onChanged: (value) {
              registerCubit.emailChanged(value);
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
            // Recordar que el valor del input lo tenemos siempre en la propiedad value
            // label: 'Contraseña ${password.value}',
            label: 'Contraseña',
            obscureText: true,
            onChanged: registerCubit.passwordChanged,
            errorMessage: password.errorMessage,
          ),

          const SizedBox(height: 20),

          FilledButton.tonalIcon(
            onPressed: () {
              // Vamos a permitir pulsar siempre el botón.
              //
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
