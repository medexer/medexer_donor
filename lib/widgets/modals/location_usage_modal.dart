import 'package:flutter/material.dart';

class LocationUsageModal extends StatelessWidget {
  const LocationUsageModal({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.music_note),
                    title: Text('Music'),
                    onTap: () {
                      // Do something related to Music
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo),
                    title: Text('Photo'),
                    onTap: () {
                      // Do something related to Photo
                      Navigator.of(context).pop();
                    },
                  ),
                  // Add more list tiles as needed
                ],
              ),
            );
          },
        );
      },
      child: Text('Open Bottom Sheet'),
    );
  }
  
}
