class RoomCategory {
  static String sportsId = "sports";
  static String moviesId = "movies";
  static String musicId = "music";
  String id;
  late String name;
  late String image;

  RoomCategory(this.id, this.name, this.image);

  RoomCategory.fromId(this.id) {
    name = id;
    image = "assets/images/$id.jpeg";

    // if(id==sportsId){
    //   name="sports";
    //   image="assets/images/sports.jpeg";
    // }else if(id==musicId){
    //   name="music";
    //   image="assets/images/music.jpeg";
    // }
  }

  static List<RoomCategory> getCategories() {
    return [
      RoomCategory.fromId(sportsId),
      RoomCategory.fromId(musicId),
      RoomCategory.fromId(moviesId),
    ];
  }
}
