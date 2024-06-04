import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Centros de Salud"),
      ),
      body:       
      InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri.uri(Uri.parse("http://cs.losbillares.com")),
        ),
        initialSettings: InAppWebViewSettings(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false,
          useHybridComposition: true,
          allowsInlineMediaPlayback: true,
          disallowOverScroll: true,
        ),
        onWebViewCreated: (controller) {
          // Puedes añadir cualquier código adicional aquí si lo necesitas
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          // Manejo de la navegación de la URL si es necesario
          return NavigationActionPolicy.ALLOW;
        },
      ),
    );
  }
}
