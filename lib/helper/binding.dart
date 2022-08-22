import 'package:get/get.dart';
import 'package:mazekty/model/song_model.dart';
import 'package:mazekty/viewModel/album_view_model.dart';
import 'package:mazekty/viewModel/all_songs_view_model.dart';
import 'package:mazekty/viewModel/artists_view_model.dart';
import 'package:mazekty/viewModel/mazekty_player_viewModel.dart';
import 'package:mazekty/viewModel/favorites_viewModel.dart';
import 'local_storage_helper/language_local_storage.dart';

class Binding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => LanguageLocalStorage());
    Get.lazyPut(() => AllSongsViewModel());
    Get.lazyPut(() => ArtistViewModel());
    Get.lazyPut(() => AlbumsViewModel());
    Get.lazyPut(() => FavoritesViewModel.instantOfFavoritesDatabase);
    Get.lazyPut(() => MazektyPlayerViewModel());
  }

}