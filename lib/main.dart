import 'package:flutter/material.dart';
import 'package:state_management/calculation.dart';
import 'package:state_management/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //BlocProvier provide to its child
      home: BlocProvider(
        create: (context) => CounterCubit(),
        child: MyHomePage(),
      ),
      routes: {
        '/calculation': (context) => CalculationPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CounterCubit cubit;
  //late ,dont check duirng construction but used only during reference

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubit = context.read<CounterCubit>();
  }

  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    String _text = " ";
    var buttonStyle =
        ElevatedButton.styleFrom(minimumSize: const Size(100, 50));
    return Scaffold(
      appBar: AppBar(
        title: Text("hello"),
      ),
      //BlocBuilder rebuilds the component when the blocs state changes
      body: BlocConsumer<CounterCubit, int>(
        builder: (context, state) {
          return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                    key: const Key("Value"),
                    decoration: const InputDecoration(labelText: 'Value'),
                    onChanged: (value) => _text = value),
              ),
              Text("$state",
                  style: TextStyle(fontSize: (state > 0 ? 100 : 50))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: (() {
                      cubit.increment();
                    }),
                    child: const Text("increment"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: (() {
                      cubit.decrement();
                    }),
                    child: const Text("decrement"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: (() {
                      cubit.restart();
                    }),
                    child: const Text("Reset"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CalculationPage(),
                        ),
                      );
                    }),
                    child: const Text("multiplication"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CalculationPage(),
                        ),
                      );
                    }),
                    child: const Text("Division"),
                  )
                ],
              )
            ]),
          );
        },
        bloc: cubit,
        listener: (context, state) {
          const snackBar = SnackBar(
            content: Text("state is reached"),
          );
          if (state == 5) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(snackBar);
          }
        },
      ),
      // body: BlocListener<CounterCubit, int>(
      //   bloc: cubit,
      //   listener: (context, state) {
      //     const snackBar = SnackBar(
      //       content: Text("state is reached"),
      //     );
      //     if (state == 5) {
      //       ScaffoldMessenger.of(context)
      //         ..clearSnackBars()
      //         ..showSnackBar(snackBar);
      //     }
      //   },
      //   child: BlocBuilder<CounterCubit, int>(
      //     bloc: cubit,
      //     //builder builds the function

      //     builder: (context, state) => Text('Counter $state'),
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       //read obj that is the instance of counterCubit
      //       // context.read<CounterCubit>().increment();
      //       cubit.increment();
      //     },
      //     child: const Icon(Icons.add)),
    );
  }
}
// class MyHomePage extends StatefulWidget {

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
