import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazekty/model/song_model.dart';
import 'package:mazekty/viewModel/mazekty_player_viewModel.dart';
import 'custom_text.dart';
import 'package:duration/duration.dart' as songDuration;

// ignore: must_be_immutable
class MusicSlide extends StatelessWidget {
  int currentSongIndex;
  int selectedSongIndex;
  List<SongModel> songs;
  List<SongModel> songsWillPlay;

  ///----------------------------------------------------------------------------
  MusicSlide(
      {this.currentSongIndex,
      this.selectedSongIndex,
      this.songsWillPlay,
      this.songs});

  ///---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return GetX<MazektyPlayerViewModel>(
      init: Get.find<MazektyPlayerViewModel>(),
      builder: (controller) => Container(
        color: (controller.duration.value != null &&
                controller.songsWillPlay[controller.currentSongIndex.value]
                        .filePath ==
                    songs[selectedSongIndex].filePath)
            ? Colors.purple.shade100
            : Colors.white,
        child: ListTile(
          leading: Icon(
            Icons.library_music,
            color: Colors.purple,
            size: 40,
          ),
          title: CustomText(
            text: songsWillPlay[currentSongIndex].displayName,
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "artist".tr +
                    ": " +
                    songsWillPlay[currentSongIndex].artist.split(" ")[0],
                fontWeight: FontWeight.normal,
                fontSize: 12.0,
              ),
              playingNowOrNo(),
            ],
          ),
          trailing: InkWell(
            onTap: optionBottomSheet,
            child: Icon(
              Icons.more_vert,
              color: Colors.purple,
            ),
          ),
          onTap: () async {
            controller.openMazektyPlayer(songs: songsWillPlay, index: selectedSongIndex);
          },

        ),
      ),
    );
  }

  GetX<MazektyPlayerViewModel> playingNowOrNo() {
    return GetX<MazektyPlayerViewModel>(
      builder: (playerController) {
        if (playerController.duration.value != null &&
            playerController
                    .songsWillPlay[playerController.currentSongIndex.value]
                    .filePath ==
                songs[selectedSongIndex].filePath) {
          return CustomText(
            text: (playerController.isPlaying.value == true)
                ? "playing".tr
                : "pause".tr,
            fontWeight: FontWeight.normal,
            fontSize: 14.0,
            fontColor: Colors.green,
          );
        } else
          return Container();
      },
    );
  }

  void getSongInfo() {
    Get.defaultDialog(
      title: "allDetails".tr,
      content: Column(
        children: [
          Divider(
            color: Colors.purple,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CustomText(
              text: "name".tr,
              fontColor: Colors.purple,
              fontWeight: FontWeight.bold,
            ),
            title: CustomText(
              fontSize: 12 ,
              text: songsWillPlay[currentSongIndex].title,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CustomText(
              text: "artist".tr,
              fontColor: Colors.purple,
              fontWeight: FontWeight.bold,
            ),
            title: CustomText(
              // text: artistName,
              text: songsWillPlay[currentSongIndex].artist,
              fontSize: 12 ,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CustomText(
              text: "size".tr,
              fontColor: Colors.purple,
              fontWeight: FontWeight.bold,
              fontSize: 12 ,
            ),
            title: CustomText(
              text: songsWillPlay[currentSongIndex].fileSize + "byte",
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CustomText(
              text: "duration".tr,
              fontColor: Colors.purple,
              fontWeight: FontWeight.bold,
            ),
            title: CustomText(
              text: songDuration.printDuration(
                Duration(milliseconds: int.parse(songsWillPlay[currentSongIndex].duration),
                ),
              ),
              fontSize: 12 ,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CustomText(
              text: "path".tr,
              fontColor: Colors.purple,
              fontWeight: FontWeight.bold,
            ),
            title: CustomText(
              text: songsWillPlay[currentSongIndex].filePath,
              fontSize: 12 ,
            ),
          ),
        ],
      ),
    );
  }

  void optionBottomSheet() {
    Get.bottomSheet(
      Container(
        height: 200,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Colors.purple,
              child: CustomText(
                text: (songsWillPlay[currentSongIndex].displayName.length > 43)
                    ? songsWillPlay[currentSongIndex]
                        .displayName
                        .substring(0, 40)
                    : songsWillPlay[currentSongIndex].displayName,
                fontColor: Colors.white,
                fontSize: 15.0,
              ),
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("details".tr),
              onTap: getSongInfo,
            ),
          ],
        ),
      ),
    );
  }
}
