import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:mazekty/viewModel/mazekty_player_viewModel.dart';
import 'package:mazekty/widget/custom_text.dart';
import 'package:mazekty/widget/player_custom_button.dart';
class MazektyPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MazektyPlayerViewModel>(
      init: Get.find<MazektyPlayerViewModel>(),
      ///Dismissible To Allow The User Swap The Player To Down
      builder: (playerController) => Dismissible(
        direction: DismissDirection.down,
        background: Material(
          color: Colors.purple,
          child: Center(
            child: CustomText(
              text: "DEVELOPED BY MOHAMED SAAD",
              fontColor: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        key: UniqueKey(),
        onDismissed: (direction) {Get.back();},
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(
              bottom: 20,
            ),
            child: Column(
              children: [
                ///This Container For Top Icons And Song Name
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 25,),
                      playerTopIcons(playerController),
                      songDisplayNameAsMarquee(context),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .1,),
                ///This Container For The Center Player Image
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 3.5,
                    backgroundImage: ExactAssetImage("assets/images/music2.jpg"),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .1,),
                ///This Row For the Five Player Buttons [play - pause - next - previous - loop]
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetX<MazektyPlayerViewModel>(
                        init: Get.find<MazektyPlayerViewModel>(),
                        builder: (controller) => CustomPlayerButton(
                          buttonFunction: () {
                            controller.setLoopModeForSelectedSong();
                          },
                          buttonHeight: MediaQuery.of(context).size.width * .1,
                          buttonIcon: CupertinoIcons.arrow_2_squarepath,
                          iconSize: 20,
                          iconColor: controller.loopAudio.value
                              ? Colors.green
                              : Colors.white,
                        ),
                      ),
                      CustomPlayerButton(
                        buttonFunction: () {
                          playerController.getPreviousSong();
                        },
                        buttonHeight: MediaQuery.of(context).size.width * .12,
                        buttonIcon: (Get.locale.languageCode == "en")
                            ? CupertinoIcons.backward_end_alt
                            : CupertinoIcons.forward_end_alt,
                        iconSize: 20,
                      ),
                      GetX<MazektyPlayerViewModel>(
                        builder: (controller) => CustomPlayerButton(
                          buttonFunction: () {
                            playerController.pauseSelectedAudioPlayer();
                          },
                          buttonHeight: MediaQuery.of(context).size.width * .15,
                          buttonIcon: (controller.isPlaying.value) == true
                              ? CupertinoIcons.pause
                              : CupertinoIcons.play,
                          iconSize: 20,
                        ),
                      ),
                      CustomPlayerButton(
                        buttonFunction: () {
                          playerController.getNextSong();
                        },
                        buttonHeight: MediaQuery.of(context).size.width * .12,
                        buttonIcon: (Get.locale.languageCode == "en")
                            ? CupertinoIcons.forward_end_alt
                            : CupertinoIcons.backward_end_alt,
                        iconSize: 20,
                      ),
                      CustomPlayerButton(
                        buttonFunction: () async
                        {
                          await playerController.addAndRemoveToFavoritesDataBaseFromPlayerUI();
                        },
                        buttonHeight: MediaQuery.of(context).size.width * .1,
                        buttonIcon: (playerController.inFavorite == false)
                            ? Icons.favorite_border
                            : Icons.favorite,
                        iconSize: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05,),
                ///This the Slider Represent The Duration And Current Position For the Current Playing Audio
                Expanded(
                  child: Column(
                    children: [
                      currentPlayingAudioSlider(),
                      audioDurationAsTextChanges(),
                    ],
                  ),
                ),
                ///This For Changes Of The Current Position And Duration As Text 00:00:00

              ],
            ),
          ),
        ),
      ),
    );
  }


 GetX<MazektyPlayerViewModel> currentPlayingAudioSlider() {
  return GetX<MazektyPlayerViewModel>(
   builder: (control) =>
    (control.position.value != null && control.duration != null)
      ? Slider.adaptive(
        activeColor: Colors.purple,
        inactiveColor: Colors.grey,
        value: control.position.value.inSeconds.toDouble(),
        min: 0,
        max: control.duration.value.inSeconds.toDouble(),
        onChanged: (double value) {
        control.movePositionTo(value);
       },
       )
      : Container(),
    );
  }

 GetX<MazektyPlayerViewModel> audioDurationAsTextChanges() {
    return GetX<MazektyPlayerViewModel>(
      builder: (control) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: control.position.value.toString().split(".")[0],
              fontColor: Colors.purple,
            ),
            CustomText(
              text: control.duration.toString().split(".")[0],
              fontColor: Colors.purple,
            )
          ],
        ),
      ),
    );
  }

 Row playerTopIcons(controller) {
  return Row(
   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
     IconButton(
       onPressed: () {
       controller.loopAudio.value = false;
        Get.back();
       },
       icon: Icon(
        CupertinoIcons.clear,
        color: Colors.purple,
       ),
    ),
     GetX<MazektyPlayerViewModel>(
      builder: (control) => IconButton(
        onPressed: () {
          control.isSilent.value = !control.isSilent.value;
          control.changeSilentMode();
        },
        icon: Icon(
          control.isSilent.value == false
              ? CupertinoIcons.speaker_1
              : CupertinoIcons.speaker_slash,
          color: Colors.purple,
        ),
      ),
        ),
      ],
    );
 }

 Container songDisplayNameAsMarquee(context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width / 1.3,
      child: GetX<MazektyPlayerViewModel>(
        builder: (playerController) => Marquee(
          text: playerController.songsWillPlay[playerController.currentSongIndex.value].displayName,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Cairo",
              fontSize: 15,
              color: Colors.purple),
          blankSpace: 50.0,
          pauseAfterRound: Duration(seconds: 5),
        ),
      ),
    );
  }

}
