import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazekty/viewModel/favorites_viewModel.dart';
import 'package:mazekty/widget/custom_text.dart';
import 'package:mazekty/widget/msuic_slide.dart';

class PlayListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoritesViewModel>(
      init: FavoritesViewModel.instantOfFavoritesDatabase,
      builder: (controller) => (controller.favSongs != null && controller.favSongs.length > 0)
      /// Build ListView For Each Audio In Favorite Play List
        ? _buildListViewToTheAudiosInTheFavoritesPlayList(controller)

      ///If The Favorite PlayList Is Empty
      : Center(
          child: CustomText(
            text: "noData".tr,
            fontFamily: "Cairo",
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontColor: Colors.purple,
          ),
        ),
    );
  }

 ListView _buildListViewToTheAudiosInTheFavoritesPlayList(
      FavoritesViewModel controller) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (d) => controller.deleteSongFavoriteDatabase(
                  controller.favSongs[index].songID),
              child: MusicSlide(
                songsWillPlay: controller.favSongs,
                songs: controller.favSongs,
                currentSongIndex: index,
                selectedSongIndex: index,
              ),
            ),
            Divider(
              height: 0,
              color: Colors.purple,
            ),
          ],
        );
      },
      itemCount: controller.favSongs.length,
    );
  }
}
