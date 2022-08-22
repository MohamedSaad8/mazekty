import 'package:get/get.dart';
import 'package:mazekty/model/song_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../constant.dart';

class FavoritesViewModel extends GetxController
{

  List<SongModel> favSongs ;
  static final FavoritesViewModel instantOfFavoritesDatabase = FavoritesViewModel._();
  static Database _favoritesDatabase;
  Future<Database> get favoritesDatabase async {
    if (_favoritesDatabase != null) {
      return _favoritesDatabase;
    } else {
      _favoritesDatabase = await initDatabase();
      return _favoritesDatabase;
    }
  }
  ///-----------------------------------------------------------------------------
  FavoritesViewModel._();

  @override
  void onInit() async {
    await getAllSongsFromFavoriteDatabase();
  }

  ///-----------------------------------------------------------------------------



  initDatabase() async {
    String path = join(await getDatabasesPath(), "favorites_db.db");
    return  await openDatabase(path, version: 1, onCreate: (Database db, int v) async {
      await db.execute('''
        CREATE TABLE $kUsersTableName (
        $kSongID TEXT PRIMARY KEY,
        $kFileSize TEXT NOT NULL,
        $kDuration TEXT NOT NULL,
        $kFilePath TEXT NOT NULL,
        $kArtist TEXT NOT NULL,
        $kAlbumID TEXT NOT NULL,
        $kAlbumName TEXT NOT NULL,
        $kTitle TEXT NOT NULL,
        $kDisplayName TEXT NOT NULL )
        ''');
    });
  }

  Future<void> insertSongInFavoriteDatabase(SongModel song) async {
    var dbClient = await favoritesDatabase;
    await dbClient.insert(kUsersTableName, song.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print("all is done mohamed saad");
    await getAllSongsFromFavoriteDatabase() ;
  }

  Future<void> deleteSongFavoriteDatabase(String songID) async {
    var dbClient = await favoritesDatabase;
    await dbClient
        .delete(kUsersTableName, where: "$kSongID = ?", whereArgs: [songID]);
    await getAllSongsFromFavoriteDatabase() ;
  }

  Future<bool> getSongByIDFromFavoriteDatabase(String songID) async {
    var dbClient = await favoritesDatabase;
    List<Map> songs = await dbClient
        .query(kUsersTableName, where: "$kSongID = ?", whereArgs: [songID]);
    if (songs.isNotEmpty) return true;
    return false;
  }

  Future<List<SongModel>> getAllSongsFromFavoriteDatabase() async {
    var dbClient = await favoritesDatabase;
    List<Map> songs = await dbClient.query(kUsersTableName);
     favSongs = songs.isNotEmpty
        ? songs.map((user) => SongModel.fromJson(user)).toList()
        :  [];
     update();
     return favSongs ;
  }

}