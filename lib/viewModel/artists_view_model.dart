import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get/get.dart';
import 'package:mazekty/model/artist_model.dart';
import 'package:mazekty/model/song_model.dart';

class ArtistViewModel extends GetxController
{
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<ArtistModel> _artists = [];
  List<ArtistModel> get artists => _artists;

  @override
  void onInit()async {
    var artists = await audioQuery.getArtists();
    var songs = await  audioQuery.getSongs();
    for(var artist in artists)
      {
        List<SongModel> artistSongs= [] ;
        for(var song in songs)
        {
          if(song.artistId == artist.id && song.duration != null)
          {
            artistSongs.add(SongModel(
                title: song.title,
                displayName: song.displayName,
                fileSize: song.fileSize,
                filePath: song.filePath,
                albumName: song.album,
                artist: song.artist,
                duration: song.duration,
                songID: song.id,
            ));
          }
        }
        _artists.add(ArtistModel(
          artistName: artist.name,
          artistArtPath: artist.artistArtPath,
          artistID: artist.id,
          numberOfAlbums: artist.numberOfAlbums,
          artistSongs: artistSongs
        ));
      }
 update();
    super.onInit();
  }
}