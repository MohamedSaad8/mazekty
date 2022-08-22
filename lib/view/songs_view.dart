import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazekty/viewModel/all_songs_view_model.dart';
import 'package:mazekty/widget/custom_text.dart';
import 'package:mazekty/widget/msuic_slide.dart';

///-----------------------------------------------------------------------------
class SongsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllSongsViewModel>(
      init: Get.find<AllSongsViewModel>(),
      builder: (controller) => (controller.allSongs.isNotEmpty)
          ? Container(
              color: Colors.white70,
              ///ListView To Display All Audios File On The Device
              child: _buildListViewForAllSongsOnDevice(controller),
            )
          /// If No Songs On Device
          : Container(
              child: Center(
                child: CustomText(
                  text: "emptyExpression".tr,
                  fontColor: Colors.purple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Cairo",
                ),
              ),
            ),
    );
  }

  ListView _buildListViewForAllSongsOnDevice(AllSongsViewModel controller) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            ///Custom Widget [Audio DisplayName , ArtistName , Icon , IconButton For The Details]
            MusicSlide(
              currentSongIndex: index,
              songsWillPlay: controller.allSongs,
              selectedSongIndex: index,
              songs: controller.allSongs,
            ),
            ///Draw Line Between Each Song
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                height: 0,
                color: Colors.purple,
              ),
            )
          ],
        );
      },
      itemCount: controller.allSongs.length,
    );
  }
}
