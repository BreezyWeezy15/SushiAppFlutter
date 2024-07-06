

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfApi {

  static Future<File> createPdf(String receipt) {
    final pdf = Document();
    pdf.addPage(
        Page(build: (context) => Center(child: Text(receipt,style: const TextStyle(fontSize: 24)))
        ));

    return _savePdf(pdf, receipt);
  }


   static Future<File> _savePdf(Document document,String receipt) async {
    final name = '${DateTime.now().microsecondsSinceEpoch}.pdf';
    final bytes = await document.save();
    final directory = await getApplicationCacheDirectory();
    File file = File('${directory.path}/$name');

    await file.writeAsBytes(bytes);
    return file;
  }

}