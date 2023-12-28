import 'dart:io';

import 'package:flutter/material.dart';

class Utils {
  static String truncateString(String input) {
    const int maxLength = 95;

    if (input.length <= maxLength) {
      return input;
    } else {
      return '${input.substring(0, maxLength)}...';
    }
  }

  static String formatTimeAgo(String datetimeString) {
    DateTime postedTime = DateTime.parse(datetimeString);
    DateTime currentTime = DateTime.now();
    Duration difference = currentTime.difference(postedTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${_pluralize(difference.inMinutes, "minute")} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${_pluralize(difference.inHours, "hour")} ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} ${_pluralize(difference.inDays, "day")} ago';
    } else {
      int months = (difference.inDays / 30).floor();
      return '$months ${_pluralize(months, "month")} ago';
    }
  }

  static String _pluralize(int value, String unit) {
    return value == 1 ? unit : '${unit}s';
  }

  static String getMimeType(File file) {
    const Map<String, String> mimeTypes = {
      'txt': 'text/plain',
      'pdf': 'application/pdf',
      'doc': 'application/msword',
      'docx':
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'ppt': 'application/vnd.ms-powerpoint',
      'pptx':
          'application/vnd.openxmlformats-officedocument.presentationml.presentation',
      'xls': 'application/vnd.ms-excel',
      'xlsx':
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    };

    // get the file extension
    final List<String> parts = file.path.split('.');
    final String extension = parts.isNotEmpty ? parts.last : '';

    // wil find the MIME type using the file extension
    final String mimeType =
        mimeTypes[extension.toLowerCase()] ?? 'application/octet-stream';

    return mimeType;
  }

  static String formatFileSize(int fileSizeInBytes) {
    const int bytesInOneKB = 1024;
    const int bytesInOneMB = 1024 * 1024;

    if (fileSizeInBytes >= bytesInOneMB) {
      double fileSizeInMB = fileSizeInBytes / bytesInOneMB;
      return '${fileSizeInMB.toStringAsFixed(2)} MB';
    } else if (fileSizeInBytes >= bytesInOneKB) {
      double fileSizeInKB = fileSizeInBytes / bytesInOneKB;
      return '${fileSizeInKB.toStringAsFixed(2)} KB';
    } else {
      return '$fileSizeInBytes bytes';
    }
  }

  static Widget getFileTypeImage(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'docx':
        return Image.asset('assets/doc.png', scale: 12);
      case 'pptx':
        return Image.asset('assets/ppt.png', scale: 12);
      case 'pdf':
        return Image.asset('assets/pdf.png', scale: 12);
      case 'zip':
        return Image.asset('assets/zip.png', scale: 12);
      case 'txt':
        return Image.asset('assets/txt-file.png', scale: 12);
      case 'png':
        return Image.asset('assets/png.png', scale: 12);
      case 'jpeg':
        return Image.asset('assets/jpeg.png', scale: 12);
      case 'jpg':
        return Image.asset('assets/jpg.png', scale: 12);
      default:
        return Image.asset('assets/folder.png', scale: 12);
    }
  }
}
