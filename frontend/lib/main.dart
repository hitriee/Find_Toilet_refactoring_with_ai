import 'package:find_toilet/core/config/state_provider.dart';
import 'package:find_toilet/pages/intro/intro_page.dart';
import 'package:find_toilet/pages/settings/presentation/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  KakaoSdk.init(nativeAppKey: dotenv.env['nativeAppKey']);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserInfoProvider()),
        ChangeNotifierProvider(create: (_) => ApplyChangeProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => ScrollProvider()),
        ChangeNotifierProvider(create: (_) => ReviewBookMarkProvider()),
        ChangeNotifierProvider(create: (_) => MapStateProvider()),
      ],
      child: MaterialApp(
        title: 'Find Toilet',
        theme: ThemeData(fontFamily: 'Noto Sans'),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        ),
        home: const IntroPage(),
      ),
    );
  }
}
