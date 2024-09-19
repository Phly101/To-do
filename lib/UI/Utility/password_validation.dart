class Pair<bool , int>{
  final bool first;
  final int second;
  Pair(this.first, this.second);
}

// error number 1: "error length<=6"
// error number 2: "error length>20"
Pair isValidPassword(String password) {
   if(password.length <= 6) {
    return Pair(false, 1);
  } else if(password.length > 20) {
    return Pair(false,2);
  } else {
    return Pair(true, 0);
   }
}