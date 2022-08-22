import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get/get.dart';
import 'package:mazekty/model/album_model.dart';
import 'package:mazekty/model/song_model.dart';

class AlbumsViewModel extends GetxController {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<AlbumModel> _albums = [];
  List<AlbumModel> get albums => _albums;

  @override
  void onInit() async {
    var albums = await audioQuery.getAlbums();
    var songs = await audioQuery.getSongs();
    for (var album in albums) {
      List<SongModel> albumSongs = [];
      for (var song in songs) {
        if (song.albumId == album.id) {
          albumSongs.add(
            SongModel(
                title: song.title,
                displayName: song.displayName,
                fileSize: song.fileSize,
                filePath: song.filePath,
                albumName: song.album,
                artist: song.artist,
                duration: song.duration,
                songID: song.id
            ),
          );
        }
      }
      _albums.add(
        AlbumModel(
            albumSongs: albumSongs,
            artistName: album.artist,
            albumID: album.id,
            title: album.title,
            albumArt: album.albumArt,
            numberOfSongs: album.numberOfSongs),
      );
    }
    super.onInit();
    update();
  }
}
