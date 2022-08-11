abstract class TraviStates {}

class TraviInitialStates extends TraviStates {}

class ChangeConstraintsBiggestHeightStates extends TraviStates {}

class ChangeIndexStates extends TraviStates {}

class GetHomeDataLoadingStates extends TraviStates {}

class GetHomeDataSuccessStates extends TraviStates {}

class GetHomeDataErrorStates extends TraviStates {}

class GetDetailsTripLoadingStates extends TraviStates {}

class GetDetailsTripSuccessStates extends TraviStates {}

class GetDetailsTripErrorStates extends TraviStates {}

class GetWeatherDetailsTripLoadingStates extends TraviStates {}

class GetWeatherDetailsTripSuccessStates extends TraviStates {}

class GetWeatherDetailsTripErrorStates extends TraviStates {}

class LikesTripLoadingStates extends TraviStates {}

class LikesTripSuccessStates extends TraviStates {}

class LikesTripErrorStates extends TraviStates {}

class SearchLoadingStates extends TraviStates {}

class SearchSuccessStates extends TraviStates {}

class SearchErrorStates extends TraviStates {}

class AddedTheCommentLoadingStates extends TraviStates {}

class AddedTheCommentSuccessStates extends TraviStates {}

class AddedTheCommentErrorStates extends TraviStates {}

class RegisterTheTripLoadingStates extends TraviStates {}

class RegisterTheTripSuccessStates extends TraviStates {}

class RegisterTheTripErrorStates extends TraviStates {}

class DeleteTheCommentLoadingStates extends TraviStates {}

class DeleteTheCommentSuccessStates extends TraviStates {}

class DeleteTheCommentErrorStates extends TraviStates {}

class GetCommentsTripLoadingStates extends TraviStates {}

class GetCommentsTripSuccessStates extends TraviStates {}

class GetCommentsTripErrorStates extends TraviStates {}

class ShowDaysTripLoadingStates extends TraviStates {}

class ShowDaysTripSuccessStates extends TraviStates {}

class ShowDaysTripErrorStates extends TraviStates {}

class ShowEventTripLoadingStates extends TraviStates {}

class ShowEventTripSuccessStates extends TraviStates {}

class ShowEventTripErrorStates extends TraviStates {}

class ShowRatingLoadingStates extends TraviStates {}

class ShowRatingSuccessStates extends TraviStates {}

class ShowRatingErrorStates extends TraviStates {}

class AddedActivitySuccessStates extends TraviStates {}

class RemovedActivitySuccessStates extends TraviStates {}

class PostActivityLoadingStates extends TraviStates {}

class PostActivitySuccessStates extends TraviStates {
  final String message;

  PostActivitySuccessStates(this.message);
}

class PostActivityErrorStates extends TraviStates {}

class AddReportLoadingStates extends TraviStates {}

class AddReportSuccessStates extends TraviStates {}

class AddReportErrorStates extends TraviStates {}
