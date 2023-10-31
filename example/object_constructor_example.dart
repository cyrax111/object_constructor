import 'package:object_constructor/object_constructor.dart';

void main() {
  final ObjectConstructor<String, FinalObject, UnderConstructedObject> objectConstructor =
      ObjectConstructor<String, FinalObject, UnderConstructedObject>();
}

class FinalObject {
  const FinalObject({
    required this.name,
    required this.status,
  });

  final String name;
  final String status;
}

class UnderConstructedObject implements UnderConstructingObject<FinalObject> {
  UnderConstructedObject({
    this.name,
    this.status,
  });

  String? name;
  String? status;

  @override
  bool get isConstructed => name != null && status != null;
  @override
  FinalObject construct() {
    if (!isConstructed) {
      throw Exception('FinalObject is not constructed yet ${toString()}');
    }
    return FinalObject(name: name!, status: status!);
  }

  @override
  String toString() => '(name: $name, status: $status)';
}
