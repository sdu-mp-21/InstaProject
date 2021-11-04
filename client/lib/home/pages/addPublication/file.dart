import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';
part 'file.g.dart';


@JsonSerializable()
class FileModel {
  final List<String> files;
  final String folder;

  FileModel(this.files, this.folder);

  factory FileModel.fromJson(Map<String, dynamic> json) => _$FileModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileModelToJson(this);
    
  
}
