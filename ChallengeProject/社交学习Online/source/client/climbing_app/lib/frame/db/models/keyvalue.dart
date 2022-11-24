import 'package:climbing_app/frame/db/models/base_model.dart';


class KeyValueModel extends BaseModel
{

  @override
  Map<String, Object> toMap() {
    // TODO: implement toMap
    return {
      "key":{
        "type":"VARCHAR(256)",
        "attr":"UNIQUE"
      },
      "value":{
        "type":"TEXT",
      },
    };
  }

}