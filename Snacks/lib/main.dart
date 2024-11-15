import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:snacks/Controller/cliente_controller.dart';
import 'package:snacks/DB/firebase_options.dart';
import 'package:snacks/Model/carrinho_model.dart';
import 'package:snacks/View/Login/home.dart';
import 'package:snacks/View/pagina_principal.dart';
import 'package:snacks/Model/cliente_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt')],
      locale: const Locale('pt'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        textTheme: Theme.of(context).textTheme.apply(
          fontSizeFactor: 1.1,
          fontFamilyFallback: ['Montserrat','Arial']
        ),
      ),
      home: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MultiProvider(
                providers: [
                  StreamProvider(create: (context) => ClienteController().getClienteStream(), initialData: ClienteModel()),
                  ChangeNotifierProvider(create: (context) => CarrinhoModel())
                ],
                child: const PaginaPrincipal()
              );
            } else {
              return const Home();
            }
          }
        ),
      )
    );
  }
}