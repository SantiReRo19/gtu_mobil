import 'package:flutter/material.dart';

class SearchRoute extends StatelessWidget {
  const SearchRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TextFormField(
            readOnly: true,
            onTap: () {},
            decoration: InputDecoration(
              hintText: '¿A dónde quieres ir?',

              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}
