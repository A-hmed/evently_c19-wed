import 'package:evently_c19/core/firebase/firestore_helper.dart';
import 'package:evently_c19/model/event_dm.dart';
import 'package:evently_c19/modules/main_layout/widgets/event_widget.dart';
import 'package:flutter/material.dart';
class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  ///Lazy initialization
  late ThemeData theme = Theme.of(context);
  late Future<List<EventDM>> eventsFuture;
  @override
  void initState() {
    super.initState();
    eventsFuture = getFavoriteEvents();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<EventDM>>(
          future: eventsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            } else if (snapshot.hasData) {
              var events = snapshot.requireData;
              return Column(
                children: [
                  buildEventsList(events),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget buildEventsList(List<EventDM> events) {
    if(events.isEmpty){
      return Expanded(child: Center(child: Text("No events found")));
    }
    return Expanded(
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) => EventWidget(eventDM: events[index]),
      ),
    );
  }
}
