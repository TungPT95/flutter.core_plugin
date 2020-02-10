import 'package:core_plugin/core_plugin.dart' as corePlugin;
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';

class ExNavigatorApp extends StatelessWidget with Routing {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: onGenerateRoute,
      home: Page1(title: 'Flutter Demo Home Page'),
    );
  }

  @override
  Map<dynamic, dynamic> getRoutes(bundle) {
    return {
      Page1: Page1(
        title: 'page 1',
      ),
      Page2: Page2(
        title: 'page 2',
      ),
      Page3: Page3(
        title: 'page 3',
      )
    };
  }
}

class Page3 extends StatefulWidget {
  Page3({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends BaseState<Page3> {
  @override
  void initState() {
//    print('${this.runtimeType} [TUNG] ===> pass bundle ${bundle.args}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {},
          child: Text('pop vao day'),
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  Page2({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends BaseState<Page2> {
  @override
  void initState() {
//    print('${this.runtimeType} [TUNG] ===> pass bundle ${bundle.args}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //todo pop with returning result
//            setResult(corePlugin.Bundle('result ne'));
//            popScreen();
            //todo pop replacement with returning result
            pushReplacementScreen(corePlugin.Intent(context, Page2),
                resultBundle: corePlugin.Bundle('result ne'));
          },
          child: Text('pop vao day'),
        ),
      ),
    );
  }
}

class Page1 extends StatefulWidget {
  Page1({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends BaseState<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            pushScreen(corePlugin.Intent(context, Page2));
//            pushForResult(corePlugin.Intent(context, Page2,
//                bundle: corePlugin.Bundle('String ne')));
          },
          child: Text('click vao day'),
        ),
      ),
    );
  }

  @override
  void onPopResult(Type returnPage, Bundle resultBundle) {
    print(
        '${this.runtimeType} [TUNG] ===> onPopResult $returnPage ${resultBundle.args}');
  }
}
