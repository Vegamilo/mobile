const double Globalver = 3.14;
String ConvertToMonth(int month){
  String monthStr = '';
  switch (month) {
    case 1: monthStr = 'January';
    break;
    case 2: monthStr = 'Febuary';
    break;
    case 3: monthStr = 'March';
    break;
    default:
    monthStr = 'Error';
  }
  return monthStr;
}
void show(var name,[String city = '']){
  print(name);
}
show2(var name) => print(name);
void main() {
  print(ConvertToMonth(1));
  print(Globalver);
  show ('Hello');
  show ('Hello 2', 'Sakon');
  show2 ('Hello 2');
}
