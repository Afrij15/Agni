import 'package:flutter/material.dart';
import 'package:wasthu/Screens/Pages/show-search.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: Column(
            children: [
              Expanded(
                child: Form(
                  child: TextFormField(
                    autofocus: true,
                    style: TextStyle(
                      fontSize: 20,
                      height: 0.50,
                    ),
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Colors.pink.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowSearch(value)),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
