class ArtistsDTO {
  final String name, about;

  ArtistsDTO({
    this.name = '',
    this.about = '',
  });

  factory ArtistsDTO.fromJson(Map<String, dynamic> json) {
    return ArtistsDTO(
      name: json['name'] as String,
      about: json['about'] as String,
    );
  }
}
