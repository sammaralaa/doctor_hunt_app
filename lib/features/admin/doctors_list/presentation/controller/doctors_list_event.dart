import 'dart:io';


abstract class DoctorsListEvent  {
  const DoctorsListEvent();
}
class GetAllDoctorsEvent extends DoctorsListEvent {

  GetAllDoctorsEvent();
}
