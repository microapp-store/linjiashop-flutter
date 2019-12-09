class JsonModel {
  String key;
  String value;
  Map toJson() {
    Map map = new Map();
    map["key"] = this.key;
    map["value"] = this.value;
    return map;
  }
}