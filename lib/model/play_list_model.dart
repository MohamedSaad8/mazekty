import 'package:mazekty/model/song_model.dart';

class FavoriteModel
{
  String playListId ;
  String playListName ;
  String numberOfSongs ;
  List<SongModel> playListSongs ;

  FavoriteModel({this.playListId, this.playListName ,this.numberOfSongs ,this.playListSongs});
}