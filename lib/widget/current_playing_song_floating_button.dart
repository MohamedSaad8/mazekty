import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mazekty/view/mazekty_player_view.dart';
import 'package:mazekty/viewModel/mazekty_player_viewModel.dart';

class CurrentPlayingSongFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<MazektyPlayerViewModel>(
        init: MazektyPlayerViewModel(),
        builder: (playController) {
          if (playController.duration.value != null) {
            return FloatingActionButton(
              backgroundColor: Colors.purple,
              child: Image.asset(
                "assets/images/source.gif",
                fit: BoxFit.cover,
              ),
              onPressed: () async{
              playController.inFavorite = await playController.favoriteDataBase.getSongByIDFromFavoriteDatabase(
                  playController.currentSong.value.songID
              );
                Get.to(
                  MazektyPlayer(),
                  fullscreenDialog: true,
                  duration: Duration(seconds: 1),
                );
              },
            );
          } else
            return Container();
        });
  }
}
