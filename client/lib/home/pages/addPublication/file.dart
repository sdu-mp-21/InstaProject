import 'package:flutter/material.dart';

part 'file.g.dart';


class FileModel {
  final List<String> files;
  final String folder;

  FileModel(this.files, this.folder);

  factory FileModel.fromJson(Map<String, dynamic> json) => _$FileModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileModelToJson(this);
    
  
}
