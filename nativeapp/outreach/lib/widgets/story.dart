import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

import '../widgets/circular_profile_item.dart';

class Story extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: FutureBuilder(
        future: Provider.of<UserProvider>(context,listen: false).users,
        builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting ? 
         SizedBox(
           height: 80,
           width: double.infinity,
         ) : Container(
           height: 80,
           child: ListView.builder(
             scrollDirection: Axis.horizontal,
             itemCount: snapshot.data.length,
             itemBuilder: (context, index) => Container(
               width: 75,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   CircularProfileItem(
                     imageUrl: snapshot.data[index].profileImageUrl,
                     radius: 32,
                   ),
                   Container(
                     width: 55,
                     child: Text(
                       snapshot.data[index].userName,
                       style: TextStyle(
                         color: Colors.grey[350],
                       ),
                       overflow: TextOverflow.ellipsis,
                      ),
                   ),
                 ],
               ),
             ),
           ),
         ),
      ),
    );
  }
}