import 'package:mazekty/model/song_model.dart';

class AlbumModel {
  String artistName;
  String title;
  String numberOfSongs;
  String albumArt;
  String albumID;
  List<SongModel> albumSongs ;

  AlbumModel(
      {this.artistName   = "unKnown",
      this.title         = "unKnown",
      this.numberOfSongs = "unKnown",
      this.albumArt      = "unKnown",
      this.albumID       = "unKnown",
      this.albumSongs
      });
}
