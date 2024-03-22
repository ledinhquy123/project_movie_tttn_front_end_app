class ApiUrl {
  static String domain = 'https://moviebooking.id.vn';
  // static String domain = 'http://127.0.0.1:8000';

  // MOVIES
  static String getMovieTrending = '$domain/api/movies/getTrendingDay';
  static String getMoviePopular = '$domain/api/movies/getPopular';
  static String getMovieNowPlaying = '$domain/api/movies/getNowPlaying';
  static String getMovieUpComing = '$domain/api/movies/getUpcoming';
  static String getMovieName = '$domain/api/movies/getSearchMovie';
  static String getActors = '$domain/api/movies/getActor/';
  static String getWeekday = '$domain/api/movies/getWeekday';
  static String getShowtime = '$domain/api/movies/getShowtime/';
  static String getShowtimeMovieWeekday = '$domain/api/movies/getShowtimeMovieId/';
  static String getSeats = '$domain/api/movies/getSeats/';
  static String reservations = '$domain/api/movies/reservations';
  static String getBill = '$domain/api/movies/getBill';
  static String getMovieComments = '$domain/api/movies/get-movie-comments/';
  static String createMovieComment = '$domain/api/movies/create-movie-comment';
  static String checkUserComment = '$domain/api/movies/check-user-comment';

  // TRANSACTIONS
  static String getTransactions = '$domain/api/transactions';
  static String createTicket = '$domain/api/transactions/createTicket';
  static String getAllTickets = '$domain/api/transactions/get-all-tickets';
  static String getTicket = '$domain/api/transactions/get-ticket/';

  // USERS
  static String signUpUser = '$domain/api/users/create';
  static String signInUser = '$domain/api/users/login';
  static String verifyEmail = '$domain/api/users/verify-email/';
  static String changePass = '$domain/api/users/change-pass';
  static String signInWithGoogle = '$domain/auth/google';
  static String updateUser = '$domain/api/users/update';
  static String checkEmailUpdate = '$domain/api/users/check-email-update';
  static String sendGoogleSignInDataToApi = '$domain/api/social/login-google';


  // COMBOS
  static String getCombos = '$domain/api/combos';
}