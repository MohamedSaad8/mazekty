import 'package:mazekty/constant.dart';

class SongModel {
  String albumName;
  String filePath;
  String artist;
  String displayName;
  String title;
  String albumID;
  String fileSize; //bytes
  String songID;
  String duration;//millSeconds

  SongModel(
      {this.albumName  = "unknown",
      this.filePath    = "unknown",
      this.artist      = "unknown",
      this.displayName = "unknown",
      this.title       = "unknown",
      this.albumID     = "unknown",
      this.fileSize    = "unknown",
      this.songID      = "unknown",
      this.duration   ,
      });

  SongModel.fromJson(Map<String, dynamic> map) {
    albumName   = map[kAlbumName];
    duration    = map[kDuration];
    filePath    = map[kFilePath];
    fileSize    = map[kFileSize];
    artist      = map[kArtist];
    displayName = map[kDisplayName];
    albumID     = map[kAlbumID];
    title       = map[kTitle];
    songID      = map[kSongID];
  }

  toJson()
  {
    return {
      kAlbumName    : albumName ,
      kDuration     : duration ,
      kFilePath     : filePath ,
      kFileSize     : fileSize ,
      kArtist       : artist ,
      kDisplayName  : displayName ,
      kAlbumID      : albumID ,
      kTitle        : title ,
      kSongID       : songID ,
    };
  }
}
