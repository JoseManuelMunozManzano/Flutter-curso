import 'package:flutter/material.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Usuario'),
      ),
      body: const _RegisterView()
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
    return Form(
      child: Column(
        children: [

          const CustomTextFormField(
            label: 'Nombre de usuario',
          ),

          const SizedBox(height: 10),

          const CustomTextFormField(
            label: 'Correo electrónico',
          ),

          const SizedBox(height: 10),

          const CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
          ),

          const SizedBox(height: 20),

          FilledButton.tonalIcon(
            onPressed: () {},
            icon: const Icon(Icons.save),
            label: const Text('Crear usuario'),
          ),
        ],
      )
    );
  }
}
