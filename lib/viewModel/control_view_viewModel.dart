import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mazekty/view/albums_view.dart';
import 'package:mazekty/view/artists_view.dart';
import 'package:mazekty/view/favorites_view.dart';
import 'package:mazekty/view/songs_view.dart';

class ControlViewViewModel extends GetxController
{
  int _navigatorValue = 0 ;
  int get navigatorValue => _navigatorValue ;
  Widget _currentScreen = SongsView();
  Widget get currentScreen => _currentScreen;

  void changeValueOfBottomNavigator(int selectedPageIndex)
  {
    _navigatorValue = selectedPageIndex ;
    switch (selectedPageIndex)
    {
      case 0 :
        {
          _currentScreen = SongsView();
          break ;
        }
      case 1 :
        {
          _currentScreen = AlbumsView();
          break ;
        }
      case 2 :
        {
          _currentScreen = ArtistsView();
          break ;
        }
      case 3 :
        {
          _currentScreen = PlayListView() ;
          break ;
        }
    }
    update();
  }
}