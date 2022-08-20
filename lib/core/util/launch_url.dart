import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum LauchProtocol {
  http,
  tel,
}

void lauchUrl({
  required BuildContext context,
  required String url,
  required LauchProtocol protocol,
}) async {
  if (protocol == LauchProtocol.http && !url.startsWith('http://')) {
    url = 'http://$url';
  }

  if (protocol == LauchProtocol.tel && !url.startsWith('tel:')) {
    url = 'tel:$url';
  }

  final parsedUrl = Uri.parse(url);

  if (await canLaunchUrl(parsedUrl)) {
    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    return;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('The link could not be opened'),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
    ),
  );
}
