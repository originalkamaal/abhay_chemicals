import 'package:cloud_firestore/cloud_firestore.dart';

class Production {
  final String batchNumber;
  final Composite composite;
  final String date;
  final String lastPaltidate;
  final Enrichment enrichment;
  final String quantities;
  // final List<Palti> paltiReport;
  final String noOfPalti;

  Production(
      {required this.batchNumber,
      // required this.paltiReport,
      required this.noOfPalti,
      required this.composite,
      required this.date,
      required this.enrichment,
      required this.quantities,
      // required this.paltiReport,
      required this.lastPaltidate});

  static Production fromSnapshot(DocumentSnapshot snap) {
    Production production = Production(
        batchNumber: snap['batchNumber'] ?? "Error",
        lastPaltidate: snap['paltiReport'].length > 0
            ? snap['paltiReport'][0]['date']
            : "NA",
        composite:
            Composite(snap['composite']['date'], snap['composite']['note']),
        date: snap['date'] ?? "Error",
        enrichment:
            Enrichment(snap['enrichment']['date'], snap['enrichment']['note']),
        noOfPalti: snap['paltiReport'].length.toString(),
        quantities: ""

        // paltiReport: (snap['paltiReport'] as List)
        //     .map((e) => Palti(e['date'], e['date'], e['date'], e['date']))
        //     .toList()
        );

    return production;
  }
}

class Composite {
  final String cdate;
  final String cnote;

  Composite(this.cdate, this.cnote);
}

class Enrichment {
  final String edate;
  final String enote;

  Enrichment(this.edate, this.enote);
}

class Palti {
  final String pdate;
  final String pnote;
  final String palti;
  final int temperature;

  Palti(this.pdate, this.pnote, this.palti, this.temperature);
}
