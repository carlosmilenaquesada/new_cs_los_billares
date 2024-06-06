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
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        
        title: const Text("Centros de Salud"),
      ),
      body: InAppWebView(
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
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          return NavigationActionPolicy.ALLOW;
        },
        onLoadStop: (controller, url) async {
          // Solución para: Cuando se pulsa lupa, el menú contextual aparece a la derecha, quedando oculto. Este código lo situa en mitad de la pantalla.
          String jsCode = """
            (function() {
              const observer = new MutationObserver((mutations) => {
                mutations.forEach((mutation) => {
                  var popover = document.querySelector('.popover');
                   if (popover) {
                    popover.classList.remove('fade', 'right', 'in');
                    popover.style.top = '0px';
                    popover.style.left = '0px';
                  }
                });
              });
              observer.observe(document.body, { childList: true, subtree: true });
            })();
          """;
          await controller.evaluateJavascript(source: jsCode);

          String jsCode1 = """
             console.log('Page loaded');
            (function() {
              if (window.innerWidth <= 403) {
                var mainDiv = document.querySelector('.col-sm-12.actionBar');
                var actionsDiv = document.querySelector('.search.form-group');
                
                if (actionsDiv) {
                  console.log('actions div found, applying styles');
                  
                  mainDiv.style.setProperty('display', 'flex');
                  mainDiv.style.setProperty('flex-direction', 'column');

                  actionsDiv.style.setProperty('margin-right', '0px');
                  actionsDiv.style.setProperty('margin-bottom', '10px');

                } else {
                  console.log('actions div not found');
                }
              } else {
                console.log('Screen width greater than 383px, styles not applied');
              }
            })();
          """;
          await controller.evaluateJavascript(source: jsCode1);
        },
      ),
    );
  }
}
