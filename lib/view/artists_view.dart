import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazekty/viewModel/artists_view_model.dart';
import 'package:mazekty/widget/custom_text.dart';
import 'artist_songs_view.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class ArtistsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArtistViewModel>(
      init: Get.find<ArtistViewModel>(),
      builder: (controller) => (controller.artists.isNotEmpty)
          ? Container(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(
                          ArtistSongs(
                            artistName: controller.artists[index].artistName,
                            songs: controller.artists[index].artistSongs,
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: (index % 2 == 0)
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                )
                              : BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                          border: Border.all(color: Colors.purple),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.person_outline_outlined,
                            size: 30,
                            color: Colors.purple,
                          ),
                          title: CustomText(
                            text: controller.artists[index].artistName,
                            fontWeight: FontWeight.bold,

                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "numberOfAlbums: ".tr + controller.artists[index].numberOfAlbums,
                                fontSize: ResponsiveFlutter.of(context).fontSize(1.8),
                              ),
                              CustomText(
                                text: "numberOfSongs: ".tr + controller.artists[index].artistSongs.length.toString(),
                                fontSize: ResponsiveFlutter.of(context).fontSize(1.8),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: controller.artists.length,
              ),
            )
          : Container(
              child: Center(
                child: CustomText(
                  text: "noArtists".tr,
                  fontColor: Colors.purple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Cairo",
                ),
              ),
            ),
    );
  }
}
