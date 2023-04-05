import 'package:flutter/material.dart';
import 'package:medexer_donor/widgets/custom_selection_box.dart';

class PersonalDetailScreen extends StatefulWidget {
   const PersonalDetailScreen({super.key});

  @override
  State<PersonalDetailScreen> createState() => _PersonalDetailScreenState();
}

class _PersonalDetailScreenState extends State<PersonalDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CustomSelectionTextField()
          ],
        )
      )
    );
  }
}