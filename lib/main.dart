import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'providers/centro_diurno_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(const CentroDiurnoApp());
}

class CentroDiurnoApp extends StatelessWidget {
  const CentroDiurnoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CentroDiurnoProvider()),
      ],
      child: MaterialApp(
        title: 'Centro Diurno Hojancha',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF78C0B4),
            primary: const Color(0xFF78C0B4),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF78C0B4),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}