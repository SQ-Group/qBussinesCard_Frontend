import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
// For web platform
import 'dart:html' as html show window, document, AnchorElement, Blob, Url;

class ContactSaver {
  static final ContactSaver _instance = ContactSaver._internal();
  factory ContactSaver() => _instance;
  ContactSaver._internal();

  /// Main method to save contact based on platform
  Future<void> saveContact(
      String phoneNumber,
      String firstName, {
        String? lastName,
        String? email,
        String? organization,
        String? notes,
      }) async {
    if (phoneNumber.isEmpty || firstName.isEmpty) {
      Get.snackbar("Invalid Input", "Phone number and name cannot be empty.");
      return;
    }

    try {
      // Handle different platforms
      if (kIsWeb) {
        await _downloadVCFWeb(phoneNumber, firstName,
            lastName: lastName, email: email, organization: organization, notes: notes);
      } else if (Platform.isAndroid || Platform.isIOS) {
        await _saveMobileContact(phoneNumber, firstName,
            lastName: lastName, email: email, organization: organization, notes: notes);
      } else {
        // Desktop platforms (Windows, macOS, Linux)
        await _downloadVCFDesktop(phoneNumber, firstName,
            lastName: lastName, email: email, organization: organization, notes: notes);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to save contact: ${e.toString()}");
    }
  }

  /// Save contact on mobile platforms (Android/iOS)
  Future<void> _saveMobileContact(
      String phoneNumber,
      String firstName, {
        String? lastName,
        String? email,
        String? organization,
        String? notes,
      }) async {
    try {
      final String fullName = lastName != null ? '$firstName $lastName' : firstName;

      if (Platform.isAndroid) {
        // Try Android intent first
        final bool intentSuccess = await _tryAndroidIntent(
            phoneNumber, fullName, email: email, organization: organization);

        if (intentSuccess) return;
      }

      // Fallback to contacts_service for both Android and iOS
      await _useContactsService(phoneNumber, firstName,
          lastName: lastName, email: email, organization: organization, notes: notes);

    } catch (e) {
      print('Error in mobile contact saving: $e');
      Get.snackbar("Error", "Failed to save contact: ${e.toString()}");
    }
  }

  /// Try Android intent to open native contact app
  Future<bool> _tryAndroidIntent(
      String phoneNumber,
      String fullName, {
        String? email,
        String? organization,
      }) async {
    try {
      // Create Android intent URL
      final Uri uri = Uri.parse(
          'intent://contacts/people/#Intent;'
              'action=android.intent.action.INSERT;'
              'type=vnd.android.cursor.dir/person;'
              'S.name=$fullName;'
              'S.phone=$phoneNumber;'
              '${email != null ? 'S.email=$email;' : ''}'
              '${organization != null ? 'S.company=$organization;' : ''}'
              'end'
      );

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
        return true;
      }
    } catch (e) {
      print('Android intent failed: $e');
    }
    return false;
  }

  /// Use contacts_service to save contact directly
  Future<void> _useContactsService(
      String phoneNumber,
      String firstName, {
        String? lastName,
        String? email,
        String? organization,
        String? notes,
      }) async {
    try {
      // Request permission
      PermissionStatus permission = await Permission.contacts.request();

      if (permission.isGranted) {
        final newContact = Contact(
          givenName: firstName,
          familyName: lastName ?? '',
          company: organization ?? '',
          phones: [Item(label: "mobile", value: phoneNumber)],
          emails: email != null ? [Item(label: "work", value: email)] : [],
        );

        await ContactsService.addContact(newContact);
        Get.snackbar("Success", "Contact saved successfully!");
      } else if (permission.isDenied) {
        Get.snackbar("Permission Required", "Please allow contacts permission to save contact.");
      } else if (permission.isPermanentlyDenied) {
        Get.snackbar(
          "Permission Denied",
          "Please enable contacts permission in settings.",
          onTap: (snack) => openAppSettings(),
        );
      }
    } catch (e) {
      print('ContactsService error: $e');
      // If contacts_service fails, try VCF download as fallback
      await _downloadVCFDesktop(phoneNumber, firstName,
          lastName: lastName, email: email, organization: organization, notes: notes);
    }
  }

  /// Download VCF file for web platform
  Future<void> _downloadVCFWeb(
      String phoneNumber,
      String firstName, {
        String? lastName,
        String? email,
        String? organization,
        String? notes,
      }) async {
    try {
      final vcfContent = _generateVCF(phoneNumber, firstName,
          lastName: lastName, email: email, organization: organization, notes: notes);

      // Create and download blob
      final bytes = Uint8List.fromList(vcfContent.codeUnits);
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = '${firstName}_contact.vcf';
      html.document.body?.children.add(anchor);
      anchor.click();
      html.document.body?.children.remove(anchor);
      html.Url.revokeObjectUrl(url);

      Get.snackbar("Success", "Contact file downloaded!");
    } catch (e) {
      Get.snackbar("Error", "Failed to download contact: ${e.toString()}");
    }
  }

  /// Save VCF file for desktop platforms
  Future<void> _downloadVCFDesktop(
      String phoneNumber,
      String firstName, {
        String? lastName,
        String? email,
        String? organization,
        String? notes,
      }) async {
    try {
      final vcfContent = _generateVCF(phoneNumber, firstName,
          lastName: lastName, email: email, organization: organization, notes: notes);

      // Get downloads directory
      Directory? directory;
      if (Platform.isWindows) {
        directory = Directory('${Platform.environment['USERPROFILE']}\\Downloads');
      } else if (Platform.isMacOS) {
        directory = Directory('${Platform.environment['HOME']}/Downloads');
      } else if (Platform.isLinux) {
        directory = Directory('${Platform.environment['HOME']}/Downloads');
      } else {
        directory = await getDownloadsDirectory();
      }

      if (directory != null && await directory.exists()) {
        final fileName = '${firstName}${lastName != null ? '_$lastName' : ''}_contact.vcf';
        final file = File('${directory.path}/$fileName');
        await file.writeAsString(vcfContent);
        Get.snackbar("Success", "Contact saved to: ${file.path}");
      } else {
        Get.snackbar("Error", "Could not access downloads folder");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to save contact: ${e.toString()}");
    }
  }

  /// Generate VCF (vCard) content
  String _generateVCF(
      String phoneNumber,
      String firstName, {
        String? lastName,
        String? email,
        String? organization,
        String? notes,
      }) {
    final fullName = lastName != null ? '$firstName $lastName' : firstName;

    String vcf = '''BEGIN:VCARD
VERSION:3.0
FN:$fullName
N:${lastName ?? ''};$firstName;;;
TEL;TYPE=CELL:$phoneNumber''';

    if (email != null && email.isNotEmpty) {
      vcf += '\nEMAIL:$email';
    }

    if (organization != null && organization.isNotEmpty) {
      vcf += '\nORG:$organization';
    }

    if (notes != null && notes.isNotEmpty) {
      vcf += '\nNOTE:$notes';
    }

    vcf += '\nEND:VCARD';
    return vcf;
  }

  /// Check if contacts permission is granted
  Future<bool> hasContactsPermission() async {
    if (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      return true; // No permission needed for file download
    }

    final status = await Permission.contacts.status;
    return status.isGranted;
  }

  /// Request contacts permission
  Future<bool> requestContactsPermission() async {
    if (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      return true; // No permission needed for file download
    }

    final status = await Permission.contacts.request();
    return status.isGranted;
  }

  /// Open app settings for permission
  Future<void> openPermissionSettings() async {
    await openAppSettings();
  }
}

// Extension for easy access (optional)
extension ContactSaverExtension on String {
  Future<void> saveAsContact(String firstName, {
    String? lastName,
    String? email,
    String? organization,
    String? notes,
  }) async {
    await ContactSaver().saveContact(
      this,
      firstName,
      lastName: lastName,
      email: email,
      organization: organization,
      notes: notes,
    );
  }
}