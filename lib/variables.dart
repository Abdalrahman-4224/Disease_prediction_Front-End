import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/asn1/asn1_parser.dart';
import 'package:pointycastle/asn1/primitives/asn1_sequence.dart';
import 'package:pointycastle/pointycastle.dart' as pc;
import "package:pointycastle/export.dart";
int? result;
var Gcode; //governorates code
var Mcode; //Magor code

class Governorate {
  String name;
  String code;

  Governorate({required this.name, required this.code});

  factory Governorate.fromJson(Map<String, dynamic> json) {
    return Governorate(
      name: json['name'],
      code: json['code'],
    );
  }
}

class DoctorsList {
  int? id; // Make id nullable
  String? name; // Make name nullable
  String? code;
  String? address;
  String? phoneNumber;

  DoctorsList({
    this.id,
    this.name,
    this.code,
    this.address,
    this.phoneNumber,
  });

  factory DoctorsList.fromJson(Map<String, dynamic> json) {
    return DoctorsList(
      id: json['id'] as int?, // Cast to int? (nullable)
      name: json['name'] as String?, // Cast to String? (nullable)
      code: json['code'] as String,
      address: json['address'] as String?, // Cast to String? (nullable)
      phoneNumber: json['phone_number'] as String?, // Cast to String? (nullable)
    );
  }
}




// String encryptWithRSA(String plainText, String publicKeyString) {
//   // Create an RSA public key from the string
//   pc.RSAPublicKey publicKey = parsePublicKeyFromPem(publicKeyString);
//
//   final cipher = pc.OAEPEncoding(pc.RSAEngine())
//     ..init(true, pc.PublicKeyParameter<pc.RSAPublicKey>(publicKey));  // true for encryption
//
//   // Convert plainText string to Uint8List
//   Uint8List data = Uint8List.fromList(utf8.encode(plainText));
//
//   // Encrypt the data and encode it to base64
//   return base64Encode(cipher.process(data));
// }
//
// pc.RSAPublicKey parsePublicKeyFromPem(String pem) {
//   pc.PemCodec codec = pc.PemCodec();
//   pc.AsymmetricKeyParameter<pc.RSAPublicKey> publicKeyParam = codec.decode(pem);
//   return publicKeyParam.key as pc.RSAPublicKey;
// }



// Create secure storage

// class KeyStorageService {
//   final _storage = FlutterSecureStorage();
//
//   Future<void> storePrivateKey(String key) async {
//     await _storage.write(key: 'privateKey', value: myPrivateKey);
//   }
//
//   Future<String?> getPrivateKey() async {
//     return await _storage.read(key: 'privateKey');
//   }
// }




const String myPrivateKey="""-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC27vGGC8TwCKhS
wb5E+S2oisbLCTuHL+D6WUwrlJZ5FDIy3qF3qZgCWpnr40O9Yj2aQh/jwiZATbem
9nTUCc5ykuNLAhYCCKv34VSgn8lIlzQ0AWT8+T6WL+x7dUxyvCjRapKwGpIuUt8N
dX/XWT3fynUZG3betv9Tiviw39YZcUNINg8CKOd+nlod46L6QzvbnDL9d/RpikQ2
KoclKNH23m0tff2mOiqldwcgQwzu1IWzdJmFbxLmPtC2lBMSWQciq3Uq5hQ+9EL7
uZ9AnHde3peBdyBXRCdrtBFOljQCwQUaG0dHA1Iq1ZNqbwUKfoghonx4l/D2Zaly
GGcCB8oFAgMBAAECggEAEU4iufs+Cs9lQPyEAXL2P0XvKI2u76R3Xdqs6nuyQMti
Z+giRTddbzrFg27REMbZrGowXLOx06gM3tx2UKK9QJ7Y2Qn3xzYTzC2Pe5xyBnRx
vOO1SBS6BEVahsYh0I7KAh/yg+DkaEGkFfPCGSVsXx6ZzwftyeoGcFxESp/6Jhc+
wXtjjPSLnm03eGXYIrsCKAPSTSxw0N5g4QUbHWeCtNPxtViZzp6taH9aQV1aPrQS
HBJjfJLP7qm+UBd8aJXPmY1twPBn9Lm0q2eztXa2gbUf/AnF3bbwr9jf89mmdvQS
Vm9ezk+ocYev9Fr7HAeFcTuosR1Mi/+T6eo3q1029wKBgQDkiNuubknM7WY2fp5m
EQ7Pr/UodY9FgsYsthqafGiwCU7j/Qm85LtSNvu7f5zeKmz3l4ejizL5Fzv46icq
jL3u93psOabEcgbpDN2E6Kt+SCAFKNf75QlqJBZQWaPAF+JaNY3MowEwVKUR/jTt
Kz2GKvQWWynLnRSXDbCpZfJIXwKBgQDM6xvRa2Fi4Sjl9bDIS1JfVf2NT+gSkG6m
4j5bMbU0xa6/TJPzbDgfd8Dcz4UNr4SpWhynuuef73Sas3KfhbuofKTCsnwRxzOU
3GH0nKz0ER1uzrHV0WEL05cr+A5oNw6HpCk8c3h/nK4t629Jl3ySsOFyku6bn2J1
pIoHy9bYGwKBgQCaNdt/Pb6hAMTLGu/J0dLbxFE6xvExp4gQXaVf/3ko6G8KmxG6
G+JnHOEK6Zaxt5EmFWMasXBo8wut8FsTdDsqCGbcpp5oysTs95h2+gXWxdaNhL0R
pcCPleBUwdgkZDmCQ8b2gjvoIAXvOUj/jQEMCuoAN+3hDpL5RuyhskAmIwKBgFK9
g8f1Uac5PuhLYgwdza7M68oJP61vQB6GL6Nm2MHsJ/j6FKsvQSIDmo4OBK1X93rh
9bwMDcZYS37Dgj7DItiPK3+pzcrn4f3zVmIMeRE7b+Tz9H5fQo4h62JHkJmn0WgX
cscD4N22B+Zmr9LJJfWdEgrPJSUVIA5cV5d6SM+NAoGAEeDZ58uzADWHrxZHKwxI
iT5S5NCwS8IV6e/b3JyrjIPZXmam2t5f4qNT4hEohyMUQhMtchGLozv8oY+iQoeW
iGUw9n88oE2eriiUUpp3l5FVJIqyNjJ6bHf411Ph7pEkWdpY1zE7hPSSXMVjgSpO
fPgKZ58TVa2XyZzVl2EPhF0=
-----END PRIVATE KEY-----
""";




Uint8List rsaSign(RSAPrivateKey privateKey, Uint8List dataToSign) {
  //final signer = Signer('SHA-256/RSA'); // Get using registry
  final signer = RSASigner(SHA256Digest(), '0609608648016503040201');

  // initialize with true, which means sign
  signer.init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));

  final sig = signer.generateSignature(dataToSign);

  return sig.bytes;
}

bool rsaVerify(
    RSAPublicKey publicKey, Uint8List signedData, Uint8List signature) {
  //final signer = Signer('SHA-256/RSA'); // Get using registry
  final sig = RSASignature(signature);

  final verifier = RSASigner(SHA256Digest(), '0609608648016503040201');

  // initialize with false, which means verify
  verifier.init(false, PublicKeyParameter<RSAPublicKey>(publicKey));

  try {
    return verifier.verifySignature(signedData, sig);
  } on ArgumentError {
    return false; // for Pointy Castle 1.0.2 when signature has been modified
  }
}


// Dummy public key, replace with your actual public key
const String publicKey = """
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtu7xhgvE8AioUsG+RPkt
qIrGywk7hy/g+llMK5SWeRQyMt6hd6mYAlqZ6+NDvWI9mkIf48ImQE23pvZ01AnO
cpLjSwIWAgir9+FUoJ/JSJc0NAFk/Pk+li/se3VMcrwo0WqSsBqSLlLfDXV/11k9
38p1GRt23rb/U4r4sN/WGXFDSDYPAijnfp5aHeOi+kM725wy/Xf0aYpENiqHJSjR
9t5tLX39pjoqpXcHIEMM7tSFs3SZhW8S5j7QtpQTElkHIqt1KuYUPvRC+7mfQJx3
Xt6XgXcgV0Qna7QRTpY0AsEFGhtHRwNSKtWTam8FCn6IIaJ8eJfw9mWpchhnAgfK
BQIDAQAB
-----END PUBLIC KEY-----

""";







// "name": "طبيب احمد ",
// "code": "9-1",
// "address": "شارع المغرب",
// "phone_number"

