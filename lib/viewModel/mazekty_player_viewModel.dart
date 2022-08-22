import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:mazekty/model/song_model.dart';
import 'package:mazekty/view/mazekty_player_view.dart';
import 'package:mazekty/viewModel/favorites_viewModel.dart';
import 'package:flutter/material.dart';

class MazektyPlayerViewModel extends GetxController {
  var currentSongIndex = 0.obs;
  var isPlaying = false.obs;
  var loopAudio = false.obs;
  var isSilent = false.obs;
  bool inFavorite = false;
  List<Audio> audios = [];
  List<SongModel> songsWillPlay;
  Rx<SongModel> currentSong = Rx<SongModel>();
  Rx<Duration> position = Rx<Duration>();
  Rx<Duration> duration = Rx<Duration>();
  AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  FavoritesViewModel favoriteDataBase = FavoritesViewModel.instantOfFavoritesDatabase;

  ///---------------------------------------------------------------------------

  ///Method To Get The Current Playing Audio Duration
  void getCurrentSongDuration() {
    _assetsAudioPlayer.current.listen((playingAudio) {
      ///Make Duration value Equal The Current Song Duration
      duration.value = playingAudio.audio.duration;
    });
  }

  ///Method To Get The Value Of The Current Position For The Current Playing Audio
  void getCurrentPosition() {
    ///Change Position As Stream
    position.bindStream(_assetsAudioPlayer.currentPosition);
  }

  ///Method To Get The PlayList Songs That Will Played
  void getPlayListSongs() {
    ///Clear The List To Add The New PlayList Songs Only
    audios.clear();
    ///Get Songs And Add Them To The PlayList
    for (var song in songsWillPlay) {
      audios.add(Audio.file(song.filePath));
    }
    update();
  }

  ///Method To Play The Selected PlayList
  ///Know The Playing Mode [play - pause] When Call This Method
  ///If This Method Was added To Favorite List Set "inFavorite" true else Set It false
  ///We Will Use This Variable [inFavorite] To Select The Icon Of Favorite
  ///Play The PlayList Started The Selected Index That Selected From User
  ///The User Who Select it in First Song by set [currentSongIndex] Then it Increment One By One
  Future<void> playSelectedAudioFile() async {
    isPlaying.bindStream(_assetsAudioPlayer.isPlaying);
    getPlayListSongs();
    inFavorite = await favoriteDataBase.getSongByIDFromFavoriteDatabase(
        songsWillPlay[currentSongIndex.value].songID);
    await _assetsAudioPlayer.open(
      Playlist(
        audios: audios,
        startIndex: currentSongIndex.value,
      ),
      showNotification: true,
    );
    currentSong.value = songsWillPlay[currentSongIndex.value] ;
    ///This To Select What Will Happen When The Current Playing Song Finished
    _assetsAudioPlayer.playlistAudioFinished.listen((Playing playing) async {
      if (currentSongIndex.value < songsWillPlay.length - 1 &&
          loopAudio.value == false && _assetsAudioPlayer.current.value.audio != null)
      {
        currentSongIndex.value = playing.index + 1;
        currentSong.value = songsWillPlay[currentSongIndex.value] ;
        inFavorite = await favoriteDataBase.getSongByIDFromFavoriteDatabase(
            songsWillPlay[currentSongIndex.value].songID);
        update();
      }
    });
    getCurrentSongDuration();
    getCurrentPosition();
  }

  ///Method To Pause The Current Playing Audio
  Future<void> pauseSelectedAudioPlayer() async {
    await _assetsAudioPlayer.playOrPause();
    isPlaying.bindStream(_assetsAudioPlayer.isPlaying);
  }

  ///Method To Change The Current Position OF The Current Playing Audio
  ///Will Use In The Slider
  void movePositionTo(double value) async{
   await _assetsAudioPlayer.seek(Duration(seconds: value.toInt()));
  }

  ///Method To Get The Previous Audio In The Same PlayList
  void getPreviousSong() async {
    _assetsAudioPlayer.previous();
    if (currentSongIndex.value > 0) {
      currentSongIndex.value--;
      currentSong.value = songsWillPlay[currentSongIndex.value] ;
      ///See If The Previous Audio Is In Favorites
      inFavorite = await favoriteDataBase.getSongByIDFromFavoriteDatabase(
          songsWillPlay[currentSongIndex.value].songID);
      update();
    }
  }

  ///Method To Get The Next Audio In The Same PlayList
  void getNextSong() async {
    _assetsAudioPlayer.next();
    if (currentSongIndex.value < songsWillPlay.length - 1) {
      currentSongIndex.value++;
      currentSong.value = songsWillPlay[currentSongIndex.value] ;
      ///See If The Previous Audio Is In Favorites
      inFavorite = await favoriteDataBase.getSongByIDFromFavoriteDatabase(
          songsWillPlay[currentSongIndex.value].songID);
    }
    update();
  }

  ///Method To Set The Loop Mode The The Current Playing Audio
  void setLoopModeForSelectedSong() {
    loopAudio.value = !loopAudio.value;
    if (loopAudio.value) {
      _assetsAudioPlayer.setLoopMode(LoopMode.single);
      Get.snackbar("notification".tr, "inLoopMode".tr ,
          duration: Duration(seconds: 2) ,
          snackPosition: SnackPosition.BOTTOM ,
          colorText: Colors.purple
      );
    } else {
      _assetsAudioPlayer.setLoopMode(LoopMode.none);
      Get.snackbar("notification".tr, "closeLoopMode".tr ,
          duration: Duration(seconds: 2) ,
          snackPosition: SnackPosition.BOTTOM ,
          colorText: Colors.purple
      );
    }
  }

  ///Method To Set The Sound Public Or Silent
  void changeSilentMode() {
    if (isSilent.value == false) {
      _assetsAudioPlayer.setVolume(1.0);
    } else {
      _assetsAudioPlayer.setVolume(0.0);
    }
  }

  ///Method See If There Song Playing Or No And IF This Song Is The Same Some
  ///That The User Clicked On It To Open And It Play Not Restart The Song
  ///Else Open The New Song
  openMazektyPlayer({List<SongModel> songs, int index}) async {
    if (songsWillPlay != null &&
        songsWillPlay[currentSongIndex.value].filePath ==
            songs[index].filePath)
    {
      ///See If The Audio Audio Is In Favorites
      inFavorite = await favoriteDataBase.getSongByIDFromFavoriteDatabase(
          songsWillPlay[currentSongIndex.value].songID);
      Get.to(
        MazektyPlayer(),
        fullscreenDialog: true,
        duration: Duration(seconds: 1),
      );
      update();
    } else {
      songsWillPlay = songs;
      currentSongIndex.value = index;
      inFavorite = await favoriteDataBase.getSongByIDFromFavoriteDatabase(
          songsWillPlay[currentSongIndex.value].songID);
      Get.to(
        MazektyPlayer(),
        fullscreenDialog: true,
        duration: Duration(seconds: 1),
      );
      update();
      await playSelectedAudioFile();
    }
  }

  ///Method For The Favorite Button In The Player On Clicked It ..obs
  ///If The Current Song Was In Favorites Delete It From Favorites Else Add It
  Future addAndRemoveToFavoritesDataBaseFromPlayerUI() async {
    bool inFavorites = await favoriteDataBase.getSongByIDFromFavoriteDatabase(
        songsWillPlay[currentSongIndex.value].songID);
    if (inFavorites) {
      favoriteDataBase.deleteSongFavoriteDatabase(
          songsWillPlay[currentSongIndex.value].songID);
      inFavorite = false;
      Get.snackbar("notification".tr, "removeFromFavorite".tr ,
          duration: Duration(seconds: 2) ,
          snackPosition: SnackPosition.BOTTOM ,
          colorText: Colors.purple
      );
      update();
    } else {
      favoriteDataBase
          .insertSongInFavoriteDatabase(songsWillPlay[currentSongIndex.value]);
      inFavorite = true;
      Get.snackbar("notification".tr, "addToFavorite".tr ,
          duration: Duration(seconds: 2) ,
          snackPosition: SnackPosition.BOTTOM ,
          colorText: Colors.purple
      );
      update();
    }
  }
}
