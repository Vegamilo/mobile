import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lab6/book.dart';
import 'package:lab6/book_page.dart';
import 'package:http/http.dart'as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Search'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();
  List<Book> books = allBooks;

List<String> items = List.generate(3, (index) => 'Item ${index + 1}');

  Future refresh() async {
    setState(() {
      items.clear(); //เคลียร์ข้อมูล
    });
    //ดึงข้อมูลตัวอย่างจากเว็บไซต์
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      //แปลงข้อมูล JSON เป็น List
      final List newItems = json.decode(response.body);
      setState(() {
        //กำหนดข้อมูลใส่ตัวแปร items
        items = newItems.map<String>((item) {
          final number = item['id'];
          return 'Item $number';
        }).toList();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MySearchDelegate());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Container(
          margin: const EdgeInsets.all(16),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Book Title',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue))),
            onChanged: searchBook,
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: books.length,
                itemBuilder: ((context, index) {
                  final book = books[index];
                  return ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Image.network(
                        book.urlImage,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(book.title),
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookPage(book: book)),
                          ));
                }))),
          items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Expanded(
            child: RefreshIndicator(
                onRefresh: refresh,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(title: Text(item));
                  },
                ),
              ),
          ),
          ],
        ),
      ),
    );
  }
  void searchBook(String query) {
    final suggestions = allBooks.where((book) {
      final bookTitle = book.title.toLowerCase();
      final input = query.toLowerCase();

      return bookTitle.contains(input);
    }).toList();
    setState(() => books = suggestions);
  }
}

class MySearchDelegate extends SearchDelegate {
  //ลิสตัวเลือก
  List<String> searchResults = [
    'Americano',
    'Espresso',
    'Cappuccino',
    'Latte',
    'Mocha',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      //กำหนดปุ่มลบข้อความในช่องค้นหา
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //กำหนดปุ่มย้อนกลับ
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    //แสดงข้อความที่เลือกจากตัวเลือกบนหน้าจอ
    return Center(
        child: Text(query,
            style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //แสดงรายการตัวเลือกโดยนำคำที่ค้น มาหาในลิสตัวเลือก
    List<String> suggestions = searchResults.where(((element) {
      final result = element.toLowerCase(); //แปลงตัวอักษรเป็นพิมพ์เล็ก
      final input = query.toLowerCase();

      return result.contains(input);
    })).toList();

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;

              showResults(context);
            },
          );
        });
  }
}
