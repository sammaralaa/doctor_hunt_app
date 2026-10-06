

abstract class DoctorsListEvent  {
  const DoctorsListEvent();
}

class GetAllDoctorsEvent extends DoctorsListEvent {
  GetAllDoctorsEvent();
}

class FilterByCategoryEvent extends DoctorsListEvent {
  final String category;

  FilterByCategoryEvent(this.category);
}
