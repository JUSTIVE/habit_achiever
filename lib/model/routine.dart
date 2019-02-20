enum RoutineEnum{Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday}

class Routine{
  List<bool> routines; 
  Routine(){
    this.routines =List<bool>();
    
    for(int i=0;i<RoutineEnum.values.length;i++){
      routines.add(false);
    }
  }
}