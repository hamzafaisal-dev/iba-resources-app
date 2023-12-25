import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_event.dart';
import 'package:iba_resources_app/constants/icons.dart';

class ReportResourceChip extends StatefulWidget {
  ReportResourceChip({
    super.key,
    required this.resourceId,
    required this.count,
  });

  int count;
  final String resourceId;

  @override
  State<ReportResourceChip> createState() => _ReportResourceChipState();
}

class _ReportResourceChipState extends State<ReportResourceChip> {
  bool _isLiked = false;

  void _toggleCount() {
    _isLiked ? widget.count -= 1 : widget.count += 1;
    _isLiked = !_isLiked;

    BlocProvider.of<ResourceBloc>(context).add(const FetchMocNigga());

    // // get the relevant document by it's id
    // DocumentReference<Map<String, dynamic>> resourceRef = FirebaseFirestore
    //     .instance
    //     .collection('/resources')
    //     .doc(widget.resourceId);

    // resourceRef.update({'reportCount': widget.count});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _toggleCount();
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.flag,
            color: Theme.of(context).colorScheme.tertiary,
            // color: Color(0XFFFF7B66),
            size: 20,
          ),
        ],
      ),
    );
  }
}
