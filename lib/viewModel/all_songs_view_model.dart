import 'dart:ui';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get/get.dart';
import 'package:mazekty/helper/local_storage_helper/language_local_storage.dart';
import 'package:mazekty/model/song_model.dart';

class AllSongsViewModel extends GetxController {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongModel> _allSongs = [];
  List<SongModel> get allSongs => _allSongs;


  @override
  void onInit() async {
    var currentAppLanguage =
        await Get.find<LanguageLocalStorage>().selectedLanguage == null
            ? "ar"
            : await Get.find<LanguageLocalStorage>().selectedLanguage;
    Get.updateLocale(Locale(currentAppLanguage));
    var songs = await audioQuery.getSongs();
    for (var song in songs) {
      if(song.duration != null)
        {
          _allSongs.add(
            SongModel(
                title: song.title,
                duration: song.duration,
                artist: song.artist,
                albumID: song.albumId,
                albumName: song.album,
                displayName: song.displayName,
                filePath: song.filePath,
                fileSize: song.fileSize,
                songID: song.id),
          );
        }
    }
    update();
    super.onInit();
  }
}
