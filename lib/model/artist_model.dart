import 'package:mazekty/model/song_model.dart';

class ArtistModel {
  String artistName;
  String artistID;
  String numberOfAlbums;
  String artistArtPath;
  List<SongModel> artistSongs ;

  ArtistModel(
      {this.artistName    = "unknown",
      this.artistID       = "unknown",
      this.numberOfAlbums = "unknown",
      this.artistArtPath  = "unknown",
      this.artistSongs
      });
}
