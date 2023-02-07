import 'package:doonamis_examen/constants/map_keys/map_keys.dart';

class Creator {
  int id;
  String? name;
  int? gender;

  Creator({required this.id, this.name, this.gender});

  Map<String, dynamic> toMap() {
    return {
      MapKeys.body.id: id,
      MapKeys.body.name: name,
      MapKeys.body.gender: gender,
    };
  }
}
