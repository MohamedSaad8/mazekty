import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:mazekty/viewModel/album_view_model.dart';
import 'package:mazekty/widget/custom_text.dart';
import 'package:get/get.dart';
import 'album_songs_view.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class AlbumsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlbumsViewModel>(
      init: Get.find<AlbumsViewModel>(),
      builder: (controller) => (controller.albums.isNotEmpty)
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: ((ResponsiveFlutter.of(context).wp(50)) / (ResponsiveFlutter.of(context).wp(55))),
              ),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.to(
                      AlbumSongsView(
                        songs: controller.albums[index].albumSongs,
                        albumName: controller.albums[index].artistName,
                      ),
                    );
                  },
                  child: _buildAlbumCardView(controller, index , context),
                ),
              ),
              itemCount: controller.albums.length,
            )
          : Container(
              child: Center(
                child: CustomText(
                  text: "noAlbums".tr,
                  fontColor: Colors.purple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Cairo",
                ),
              ),
            ),
    );
  }

  Container _buildAlbumCardView(AlbumsViewModel controller, int index , context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.purple),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Image.asset(
              "assets/images/album11.jpg",
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.width / 4,
            ),
          ),
          Divider(
            height: MediaQuery.of(context).size.width*.01,
            color: Colors.purple,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        FittedBox(
                          child: CustomText(
                          fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
                          text: (controller.albums[index].title.length > 20)
                          ? controller.albums[index].title.substring(0, 19) + "..."
                              : controller.albums[index].title,
                          fontWeight: FontWeight.bold,
                          ),
                          fit: BoxFit.scaleDown,
                        ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CustomText(
                          fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
                          text: (controller.albums[index].artistName.length > 20)
                            ? controller.albums[index].artistName.substring(0, 19) + "..."
                            : controller.albums[index].artistName,
                        ),
                    )
                    ],
                  ),
                  showAlbumDetails(controller ,index , context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InkWell showAlbumDetails(AlbumsViewModel controller, int index , context) {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          title: "allDetails",
          content: Column(
            children: [
              Divider(
                color: Colors.purple,
              ),
              ListTile(
                leading: CustomText(
                  text: "name".tr,
                  fontColor: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
                title: CustomText(
                  text: controller.albums[index].title,
                ),
              ),
              ListTile(
                leading: CustomText(
                  text: "artist".tr,
                  fontColor: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
                title: CustomText(
                  text: controller.albums[index].artistName,
                ),
              ),
              ListTile(
                leading: CustomText(
                  text: "numberOfSongs".tr,
                  fontColor: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
                title: CustomText(
                  text: controller.albums[index].numberOfSongs,
                ),
              ),
            ],
          ),
        );
      },
      child: Icon(
        Icons.info_outline,
        color: Colors.purple,
        size: ResponsiveFlutter.of(context).fontSize(3),
      ),
    );
  }
}
