abstract class TripRepo {
  getAllTrips();

  getDataForHomeScreen();

  getDetailsForTrips(int id);

  getWeatherDetailsForTrips(int id);

  likeTrip(int id);

  disLikeTrip(int id);

  search({required String query});

  showOfferedTrips();

  showRecommendedTrips();

  showBestTrips();

  addComment({required String comment, required int id});

  showComments({required int id});

  showDays({required int id});

  showEvent({required int id});

  showActivity();

  postActivity({required List<String> activities});

  addRate({required String comment, required String star, required int id});

  showRating({required int id});

  addReport({required int id, required String header, required String subject});

  deleteUserActivity({required List activity});

  updateComment(
      {required String comment, required int id, required int idTrip});

  deleteComment({required int id, required int idTrip});

  regiterTrip({required int id});


}
