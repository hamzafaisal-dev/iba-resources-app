import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/resource_tile_widgets/resource_type_chip.dart';

class ViewResourceDetailsScreen extends StatefulWidget {
  const ViewResourceDetailsScreen({super.key, this.resourceMap});

  final Map<String, ResourceModel>? resourceMap;

  @override
  State<ViewResourceDetailsScreen> createState() =>
      _ViewResourceDetailsScreenState();
}

class _ViewResourceDetailsScreenState extends State<ViewResourceDetailsScreen> {
  bool _isBookmarked = false;
  bool _isDownloading = false;

  void _downloadResource(List<dynamic> fileDownloadUrls) async {
    // takes in list of download URLs, loops over the list, downloads each file onto phone
    for (String fileUrl in fileDownloadUrls) {
      await FileDownloader.downloadFile(
        url: fileUrl,
        onDownloadCompleted: (path) {
          // final File file = File(path);
          print('Download successful!');
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    late ResourceModel resource;

    if (widget.resourceMap != null) {
      resource = widget.resourceMap!['resourceObject']!;
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //

            // resource title + bookmark icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //
                // resource title
                Flexible(
                  // will wrap text
                  child: Text(
                    resource.resourceTitle,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),

                // bookmark resource
                IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      _isBookmarked = !_isBookmarked;
                    });
                  },
                  icon: _isBookmarked
                      ? Icon(
                          Icons.bookmark,
                          size: 40,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : Icon(
                          Icons.bookmark_outline,
                          size: 40,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // pfp + username
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // pfp + username
                Row(
                  children: [
                    // pfp
                    const CircleAvatar(
                      radius: 13,
                      backgroundImage: AssetImage('assets/avatar.png'),
                    ),

                    const SizedBox(width: 6),

                    // username
                    Text(
                      resource.uploader,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            Wrap(
              children: [
                //
                ...resource.relevantFields!.map(
                  (relevantField) => ResourceTypeChip(
                    label: relevantField,
                    fontSize: 15.5,
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    textColor: Theme.of(context).colorScheme.primary,
                  ),
                ),

                ResourceTypeChip(label: resource.resourceType, fontSize: 16),
              ],
            ),

            const SizedBox(height: 12),

            // teacher name
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
                children: [
                  const TextSpan(
                    text: 'Teacher: ',
                  ),
                  TextSpan(
                    text: resource.teacherName,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // resource description
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
                children: [
                  const TextSpan(
                    text: 'Description: ',
                  ),
                  TextSpan(
                    text: resource.resourceDescription,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            Center(
              child: FilledButton(
                onPressed: _isDownloading
                    ? null
                    : () {
                        setState(() {
                          _isDownloading = !_isDownloading;
                        });

                        _downloadResource(resource.resourceFiles!);

                        setState(() {
                          _isDownloading = !_isDownloading;
                        });
                      },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    Icon(Icons.download_rounded, size: 28),

                    SizedBox(width: 8),

                    Text(
                      'Download Files',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
