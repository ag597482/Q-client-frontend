class Q {
  String? id;
  String? name;
  int? startRange;
  int? endRange;
  int? maxInQueueLimit;
  String? description;

  Q(
      {required this.name,
      this.description,
      this.startRange,
      this.endRange,
      this.maxInQueueLimit});

  Q.fromJson(Map<String, dynamic> json)
      : id = (json['id'] ?? "Na") as String,
        name = (json['name'] ?? "Na") as String,
        description = (json['description'] ?? "Na") as String,
        startRange = (json['startRange'] ?? 0) as int,
        endRange = (json['endRange'] ?? 0) as int,
        maxInQueueLimit = (json['maxInQueueLimit'] ?? 0) as int;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'startRange': startRange,
        'endRange': endRange,
        'maxInQueueLimit': maxInQueueLimit,
        'description': description,
      };
}
