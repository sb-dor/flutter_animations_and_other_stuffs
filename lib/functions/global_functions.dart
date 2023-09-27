import 'dart:async';

class GlobalFunctions {
  //timer for refreshing
  Timer? refreshTimer;

  //this function refreshes timer every time when you are calling this func
  //if you want to use your request such as "search request" or something in the future
  //use this function
  void timerRefresher() async {
    //sees if timer is active cancels the timer
    if ((refreshTimer?.isActive ?? false)) {
      refreshTimer?.cancel();
    }
    //then it sets new value for timer that it will work after 3 seconds
    refreshTimer = Timer(const Duration(seconds: 3), () async {
      //do your stuff here
    });
  }
}
