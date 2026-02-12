abstract class ToJsonItem {
  Map<String, dynamic> toJson();

  Map<String, dynamic> toProdJson() => toJson();
}
