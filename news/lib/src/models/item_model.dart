import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

@JsonSerializable()
class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  ItemModel(this.id, this.deleted, this.type, this.by, this.time, this.text, this.dead, this.parent, this.kids, this.url, this.score, this.title, this.descendants);

  toMap() {
    return {
      'id': id,
      'deleted': deleted ? 1 : 0,
      'type': type,
      'by': by,
      'time': time,
      'text': text,
      'dead': dead ? 1 : 0,
      'parent': parent,
      'kids': jsonEncode(kids),
      'url': url,
      'score': score,
      'title': title,
      'descendants': descendants
    };
  }

  ItemModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      deleted = json['deleted'] ?? false,
      type = json['type'],
      by = json['by'] ?? '',
      time = json['time'],
      text = json['text'] as String ?? '',
      dead = json['dead'] as bool ?? false,
      parent = json['parent'] as int,
      kids = json['kids'] as List ?? [],
      url = json['url'] as String,
      score = json['score'] as int,
      title = json['title'] as String,
      descendants = json['descendants'] as int ?? 0;

  factory ItemModel.fromDb(Map<String, dynamic> json) {
    return ItemModel(
        json['id'] as int,
        (json['deleted'] == 1),
        json['type'] as String,
        json['by'] as String,
        json['time'] as int,
        json['text'] as String,
        (json['dead'] == 1),
        json['parent'] as int,
        jsonDecode(json['kids']) as List,
        json['url'] as String,
        json['score'] as int,
        json['title'] as String,
        json['descendants'] as int);
  }
}