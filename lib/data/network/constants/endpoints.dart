class Endpoints {
  // to make the class non-instantiable
  Endpoints._();

  // base url
  static const String BASE_URL = "https://apiqacss.calindasoftware.com/api/v4/";

  // token
  static const String TOKEN =
      "5699057|PQIae1velN1lza0UZjkx6Z0R+Im9L2aZIS2Wp+wMgWU=";

  // headers
  static const Map<String, String> HEADERS = {
    'accept': 'application/json; charset=UTF-8',
    'Content-Type': 'application/json',
    'j_token': TOKEN
  };

// booking endpoints
  static const String CONTRACTORS = BASE_URL + "recipients";
}
