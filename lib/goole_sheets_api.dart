import 'package:gsheets/gsheets.dart';

class GoogleApi {
  // creadention

  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "mystickynotesapp-375204",
  "private_key_id": "6c8d0d5e7677096440ddc718778544e630d1f2f0",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQD89btScYOsYl3E\nC/DAJTJ46EfHTkv7EHTQsyOwMeLdiXJyTzWVOIVhT+6K/LBES53s6XnVfROCa9tv\n+cwYcjrHeZ9xkjrcQK4MIeqGPc1wpxRsHbLTccnlLQb0r2yNWwXr/7TCKyNyDvX+\nBI0f8seKii3xifsziyVe3lmSpQU0a+TR7aEQKxplQm7R7L+5t8EGx0+s3JY0MLyN\noaUNfXBj+R/4hUjhq4K46ZjR21V8T8YfXx8b9/LBra4GSBKPSPd3K79PByP8+Kr2\nsTvLz5M21fvGLZr/d+4jBD4P9haJMGLYfIOR3wENNsaZE/vTkPnFkaUIDUrWQFC3\noYFtC2xxAgMBAAECggEACmLkkeFZhgo76nnlsyUa9MG2lhrRj9Yc6xk6ja20BdUP\nIpZnVmB/gmMlIc2UDlK0gfX21nHeRE/2S0YMapc2G/eE48WOZ10t1oE+4su4KUZo\nSAkLsKUV3VCfwZn6VJm4ZE3Qm0zMXOQX7ESTIJsipr4/CK3Z50OpyHuhJQHVkYp6\nVLPCIsJ6T4iJgiIUFf3dDH4Qm6kWrnwk/SNmMzyaa6atUQiB/SPLP0pRUMUtQbk5\nf1w49vhSmytoW8bEdAx2k5cuHgBq5CJ8YT2J8H34gEDOGHEYOyZocIV6Fep83ht7\nCVgw+4Ki3oVkBtZFfqaiSx0pIy/z1Y0+yuRe/H2laQKBgQD/t5TVY5SB8CdJwhkz\n0FRKtJKUP/Q5rac2s9wbSnco+SDleDIhQJRBDoBleJnO+r1pEe8s8b+DKWGxuPP8\nP3BTcNPqRGgBu4+pAPcf9Xt8zXR1hrLgi2R/YojMCmLKhYSzxXwpu9vuQ9pW8OvC\nkVMFT58jgSm4MEl0xXENx3NxtwKBgQD9PV6X2Y+Um9HVVm9xWf3tYE6WxXnt0/Zt\n8dX25WiOIcgXGJR9aXJL4SUWz2OU3CigGW4N+qgqbTWkThaQtLAIQCU6AXANQH84\ncia56GRFmU+VpaXVuTtSsYsTEg7AQYoLgpL0tAgss4+RL7qjTOKOSaUQB0g2xels\nPlXR6yFzFwKBgQC5asPgdnQYQ6o5MSRVDZoRER23oSfVKrU0VPYkU7pTW1EfEihH\nNCxLf9hZuzjLe8Qbi4WBcUkMMdVEqHdBUD6CQi1mkHNZzkY8pRaLddQ0ikUHcsQB\nTRFxzGCkkmNPtcCjGW8OU8kE2u5WXBqW2gj4sOMTO3SkuV6J7SAsfZKXwQKBgQDd\nyEVzz8IDcIPQxyZKq3nLzrCFMuWZ+Cy2FTpCRJ/Q+pz2PTyuqQ7EjaWh2HdqA3ZA\n4ISWEZP9tC9qekkg6l3Qm/z+VAwCTx4cHTz1TCWlHqOod65JAzSFM6CNTx9EGSIA\n+pYhYRpXq9psWNSn98niu3SoGPiRn7rSZbVbZwWgeQKBgE8Eg9ujE+Z8zzLw3QjH\nja5RnjuZxZJlSaO4iTD6Ewjd6Y7ljusd9McDHi3Zf6W7QpVOBUmhZTFTqwoJ3Eno\ndwdoB8WdQ2OU8RIyclJQQhxomc3O4Dx3pIIUFB5gfw1spdvwTWGn0HTR1/hL1kLU\nPCwp1vpNQXzMKv234cmL6UHi\n-----END PRIVATE KEY-----\n",
  "client_email": "stickynotes@mystickynotesapp-375204.iam.gserviceaccount.com",
  "client_id": "113319372620153048763",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/stickynotes%40mystickynotesapp-375204.iam.gserviceaccount.com"
}

''';
// set up connection to spreedsheets
  static const _ssId = '1LWFbBOuXUa70K-FEQdEkNC8GQDJze9pWiXncDqOXCQY';
  static final _gsheet = GSheets(_credentials);
  static Worksheet? _worksheet;

  // some variable to keep track..
  static int numberOfnotes = 0;
  static List<String> currentesNotes = [];
  static bool loading = true;

  //init the spreadsheets
  Future init() async {
    // fetch spreadsheet by its id
    final ssheet = await _gsheet.spreadsheet(_ssId);
    countRow();

    //get worksheet by its titile
    _worksheet = ssheet.worksheetByTitle('Sheet1');
  }

// count number of notes already exits
  static Future countRow() async {
    while (
        (await _worksheet?.values.value(column: 1, row: numberOfnotes + 1)) !=
            '') {
      numberOfnotes++;
    }
    // let's load data
    loadNotes();
  }

  /// loading timer

  static Future loadNotes() async {
    if (_worksheet == null) return;
    for (int i = 0; i < numberOfnotes; i++) {
      final String newNote =
          await _worksheet!.values.value(column: 1, row: i + 1);
      if (currentesNotes.length < numberOfnotes) {
        currentesNotes.add(newNote);
      }
    }

    loading = false;
  }

  static Future insert(String note) async {
    if (_worksheet == null) return;
    numberOfnotes++;
    currentesNotes.add(note);
    await _worksheet!.values.appendRow([note]);
  }
}
