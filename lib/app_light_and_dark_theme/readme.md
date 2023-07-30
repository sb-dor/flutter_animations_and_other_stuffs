use theme like in MaterialApp widget it will be more changeable

    void main() async {
        WidgetsFlutterBinding.ensureInitialized();
        // await Jiffy.setLocale('ru');
        runApp(const MyApp());
    }

    //if you want change the app color immediately with states, just write your own theme and put the material app
    //in stateless widget, out of main func
    class MyApp extends StatelessWidget {
        const MyApp({Key? key}) : super(key: key);
    
        @override
        Widget build(BuildContext context) {
            debugPrint(
            "width: ${MediaQuery.of(context).size.width} | height: ${MediaQuery.of(context).size.height}");
        return MaterialApp(
            //init light theme by default
            theme: AppTheme.light,
            //init dark theme
            darkTheme: AppTheme.dark,
            //here change the theme
            themeMode: ThemeMode.dark,
            home: const HomeScreen(),
            debugShowCheckedModeBanner: false);
        }
    }