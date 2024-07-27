import 'package:comment_lines_remover/commons/colors.dart';
import 'package:comment_lines_remover/commons/strings.dart';
import 'package:comment_lines_remover/services/mobile_download.dart';
import 'package:comment_lines_remover/services/web_download.dart';
import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// import 'mobile_download.dart' if (dart.library.html) 'web_download.dart' as dl;

Future<bool> pdfGenerator(String code) async {
  try{

    List<String> linesOfCodes = [];
    for (String line in code.split('\n')) {
      linesOfCodes.add(line);
    }

    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(0),
      orientation: pw.PageOrientation.portrait,
      build: (context) => [pw.Padding(
        padding: const pw.EdgeInsets.all(20),
        child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Text(MyStrings.appName,
              style: pw.TextStyle(
                color: PdfColor.fromInt(MyColors.primary.value),
                fontSize: 36,
              )),
          pw.SizedBox(height: 10),
          pw.Text('Code: ',
              style: pw.TextStyle(
                color: PdfColor.fromInt(MyColors.primary.value),
                fontSize: 25,
              )),
          pw.SizedBox(height: 10),
          for(int i = 0; i<linesOfCodes.length; i++)
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 10, bottom: 2),
              child: pw.Text(linesOfCodes[i],
                style: pw.TextStyle(
                  color: PdfColor.fromInt(MyColors.secondary.value),
                  fontSize: 15,
                )
              ),
            ),
          pw.SizedBox(height: 10),
        ]),
      )],
    ));

    kIsWeb?saveAndLaunchFileWeb(await pdf.save(), 'comments removed code by Comment Lines Remover.pdf'):saveAndLaunchFile(await pdf.save(), 'comments removed code by Comment Lines Remover');
    return true;
  }
  catch(e){
    return false;
  }
}
