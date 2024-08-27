import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'chat.dart';
import 'newchat.dart';


dynamic bg = const Color.fromARGB(255, 29, 18, 43);
dynamic fli = const Color.fromARGB(255, 86, 33, 192);


void main() {
  runApp(const MyApp());
}



class ChatDeets {
  String name;
  ImageProvider? pfp;
  String rec;

  ChatDeets(this.name, this.pfp, this.rec);

  factory ChatDeets.fromJSON(Map<String, dynamic> json) {
    try {
      String name = json['name'] ?? 'Unknown';
      ImageProvider? pfp;
      String rec = json['rec'];
      if (json['pfp'] != null) {
        pfp = AssetImage(json['pfp']);
      }
      return ChatDeets(name, pfp, rec);
    } catch (e) {
      return ChatDeets('Unknown', const AssetImage('assets/default_avatar.png'), "null");
    }
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/newchat': (context) => const NewChat(),
        '/chat': (context) => const Chat(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatDeets> chatList = [];

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  void _loadChats() async {
    String jsonString = await rootBundle.loadString('assets/chatdeets.json');
    List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      chatList = jsonData.map((json) => ChatDeets.fromJSON(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 0),
      child: Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        title: const Text(
          "ChatHive",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.qr_code_scanner_rounded),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt_outlined),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        
        children: [
          Container(
            
            height: 80,
            padding: const EdgeInsets.all(16),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Ask Meta AI or Search",
                fillColor: const Color.fromARGB(255, 27, 27, 44),
                filled: true,
                prefixIcon: Image.asset(
                  'assets/meta_ai.gif',
                  width: 5,
                  height: 5,
                  scale: 5,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: Row(
              children: [
                SizedBox(
                  width: 38,
                  height: 30,
                  child: TextButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 30, 16, 53),
                      ),
                      padding: WidgetStatePropertyAll(EdgeInsets.all(1)),
                    ),
                    child: const Text(
                      "All",
                      style: TextStyle(color: Color.fromARGB(255, 92, 52, 152)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: 65,
                  height: 30,
                  child: TextButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromRGBO(38, 38, 44, 1),
                      ),
                      padding: WidgetStatePropertyAll(EdgeInsets.all(1)),
                    ),
                    child: const Text(
                      "Unread",
                      style: TextStyle(color: Colors.white38),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: 90,
                  height: 30,
                  child: TextButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromRGBO(38, 38, 44, 1),
                      ),
                      padding: WidgetStatePropertyAll(EdgeInsets.all(1)),
                    ),
                    child: const Text(
                      "Favourites",
                      style: TextStyle(color: Colors.white38),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: 70,
                  height: 30,
                  child: TextButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromRGBO(38, 38, 44, 1),
                      ),
                      padding: WidgetStatePropertyAll(EdgeInsets.all(1)),
                    ),
                    child: const Text(
                      "Groups",
                      style: TextStyle(color: Colors.white38),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            
            child: ListView.builder(
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                ChatDeets chat = chatList[index];
              return ListTile(
  leading: CircleAvatar(
    radius: 25,
    backgroundImage: chat.pfp,
  ),
  title: Transform.translate(
    offset: const Offset(-7, 0), 
    child: Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              chat.name,
              style: const TextStyle(color: Colors.white,fontSize: 16),
            ),
            const Text(
              "Yesterday",
              style: TextStyle(color: Colors.white54, fontSize: 12),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        const SizedBox(height: 2), 
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 2),
            Expanded(
              child: Text(
                chat.rec,
                style: const TextStyle(color: Colors.white54, fontSize: 15),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    ),),
    
  ),
  onTap: () {
    Navigator.pushNamed(context, '/chat', arguments: chat);
  },
);
  },),),],),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/newchat');
        },
        backgroundColor: fli,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: const ImageIcon(AssetImage('assets/newchat.png'),color: Colors.black,),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: bg,
        selectedItemColor: const Color.fromARGB(255,217,253,211),
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            
            icon: Icon(Icons.chat),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: "Updates",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: "Community",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: "Calls",
          ),
        ],
      ),
    ),
    );
  }
}