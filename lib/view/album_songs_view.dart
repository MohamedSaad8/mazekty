import 'package:flutter/material.dart';
import 'package:mazekty/model/song_model.dart';
import 'package:mazekty/widget/current_playing_song_floating_button.dart';
import 'package:mazekty/widget/custom_text.dart';
import 'package:mazekty/widget/msuic_slide.dart';

// ignore: must_be_immutable
class AlbumSongsView extends StatelessWidget {
  List<SongModel> songs;
  String albumName;
  AlbumSongsView({this.songs, this.albumName});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        floatingActionButton: CurrentPlayingSongFloatingButton(),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.purple,
              floating: true,
              pinned: true,
              expandedHeight: 300.0,
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                title: CustomText(
                  text: albumName,
                  fontWeight: FontWeight.bold,
                  fontColor: Colors.white,
                  fontSize: 18,
                ),
                background: Image.asset("assets/images/album.png"),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return MusicSlide(
                  currentSongIndex: index,
                  songsWillPlay: songs,
                  selectedSongIndex: index,
                  songs: songs,
                );
              }, childCount: songs.length),
            ),
          ],
        ),
      ),
    );
  }
}
