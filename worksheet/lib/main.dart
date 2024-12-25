import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// local imports
import 'node.dart';

List<Node> decisionMap = [];
:MediaQuery
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String csv = "assets/decision_map.csv";
  String contents = await rootBundle.loadString(csv);

  List<String> rows = contents.split("\n");

  for (String line in rows) {
    List<String> cells = line.split(",");
    Node node = Node(int.parse(cells[0]), int.parse(cells[1]), cells[2]);
    decisionMap.add(node);
  }

  runApp(const MaterialApp(
    home: MyFlutterApp(),
  ));
}

class MyFlutterApp extends StatefulWidget {
  const MyFlutterApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyFlutterState();
  }
}

class MyFlutterState extends State<MyFlutterApp> {
  late Node currentNode;

  @override
  void initState() {
    super.initState();
    currentNode = decisionMap.first;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  void buttonHandler() {
    setState(() {
      for (Node nextNode in decisionMap) {
        if (nextNode.iD == currentNode.nextID) {
          currentNode = nextNode;
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3e87c5),
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Align(
                    alignment: const Alignment(0.0, 0.0),
                    child: MaterialButton(
                      onPressed: () {
                        buttonHandler();
                      },
                      color: const Color(0xff3a21d9),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      textColor: const Color(0xfffffdfd),
                      height: 40,
                      minWidth: 140,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: const Text(
                        "Next",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal),
                      ),
                    )),
                Align(
                  alignment: const Alignment(0.0, -0.7),
                  child: Text(
                    currentNode.description,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 34,
                      color: Color(0xffffffff),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
