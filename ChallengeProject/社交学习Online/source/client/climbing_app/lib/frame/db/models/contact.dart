import 'package:climbing_app/frame/db/models/base_model.dart';


class ContactModel extends BaseModel
{

  @override
  Map<String, Object> toMap() {
    // TODO: implement toMap
    return {
      "displayname":{
        "type":"VARCHAR(256)",
      },
      "mail":{
        "type":"VARCHAR(256)",
      },
      "mobile":{
        "type":"VARCHAR(256)",
      },
    };
  }


}