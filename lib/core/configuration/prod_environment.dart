Map<String, dynamic> get prodEnvironment {
  return {
    'name': 'LetTutor',
    'environment': 'dev',
    'baseUrl': 'https://sandbox.api.lettutor.com',
    "header": {
      "Accept": "application/json, text/plain, */*",
      "Accept-Encoding": "gzip, deflate, br",
      "Accept-Language": "en-US,en;q=0.9",
      "Content-Type": "application/json",
      "Origin": "https://sandbox.app.lettutor.com",
      "Referer": "https://sandbox.app.lettutor.com/",
      "Sec-Ch-Ua": "Microsoft Edge;v=117, Not;A=Brand;v=8, Chromium;v=117",
      "Sec-Ch-Ua-Mobile": "?1",
      "Sec-Ch-Ua-Platform": "Android",
      "Sec-Fetch-Dest": "empty",
      "Sec-Fetch-Mode": "cors",
      "Sec-Fetch-Site": "same-site"
    },
    "primaryColor": "blue",
    "enableRemoteConfigFirebase": true,
    "enableFirebaseAnalytics": true,
    "countryCodeDefault": "VN"
  };
}
