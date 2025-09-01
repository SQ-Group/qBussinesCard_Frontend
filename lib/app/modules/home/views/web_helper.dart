import 'dart:html' as html;

dynamic webCreateBlob(List<int> bytes) {
  return html.Blob([bytes], 'text/vcard');
}

String webCreateObjectUrl(dynamic blob) {
  return html.Url.createObjectUrlFromBlob(blob);
}

void webDownloadFile(String url, String fileName) {
  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", fileName)
    ..click();
}

void webRevokeObjectUrl(String url) {
  html.Url.revokeObjectUrl(url);
}
