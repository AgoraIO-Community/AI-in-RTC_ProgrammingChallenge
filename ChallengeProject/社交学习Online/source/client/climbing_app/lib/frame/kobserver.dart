class KOBServer {
  static Map<String, List<Map<String, dynamic>>> eventMaps = new Map();

  static void registerKVO(Object obj, String eventName, Function(dynamic) callback) {
    List<Map<String, dynamic>> lists = eventMaps[eventName];
    if (lists == null) {
      lists = new List();
    }

    String className = obj.runtimeType.toString();
    bool hasIncluded = false;
    for (Map eventInfo in lists)
    {
      if (className == eventInfo["type"])
      {
        eventInfo["callback"] = callback;
        hasIncluded = true;
        break;
      }
    }

    if (hasIncluded == false)
    {
      lists.add({
        "type":obj.runtimeType.toString(),
        "callback":callback
      });
    }
    eventMaps[eventName] = lists;
  }

  static void postKVO(eventName, dynamic obj)
  {
    List<Map<String, dynamic>> lists = eventMaps[eventName];
    if (lists != null) {
      for (Map info in lists)
      {
        Function(dynamic) callback = info["callback"];
        if (callback != null)
        {
          callback(obj);
        }
      }
    }
  }

  static void removeKVO(eventName, Object obj)
  {
    List<Map<String, dynamic>> lists = eventMaps[eventName];
    if (lists != null) {
      int deleteIndex = -1;
      for (int i = 0; i<lists.length; i++)
      {
        Map info = lists[i];
        String type = info["type"];
        if (type == obj.runtimeType.toString())
        {
          deleteIndex = i;
          break;
        }
      }
      Future.microtask((){
        if (deleteIndex > -1)
        {
          lists.removeAt(0);
        }
        eventMaps[eventName] = lists;
      });
    }
  }

}
