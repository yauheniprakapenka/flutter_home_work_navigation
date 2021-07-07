import 'dart:convert';

import 'package:skillbox_navigation/data/models/artists_dto.dart';

List<ArtistsDTO> parseArtists(String artistsFile) {
  final decodedFile = jsonDecode(artistsFile).cast<Map<String, dynamic>>();
  return decodedFile
      .map<ArtistsDTO>((json) => ArtistsDTO.fromJson(json))
      .toList();
}
