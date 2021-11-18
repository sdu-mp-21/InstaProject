// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileModel _$FileModelFromJson(Map<String, dynamic> json) {
  return FileModel(
    (json['files'] as List<dynamic>).map((e) => e as String).toList(),
    json['folder'] as String,
  );
}

Map<String, dynamic> _$FileModelToJson(FileModel instance) => <String, dynamic>{
      'files': instance.files,
      'folder': instance.folder,
    };
