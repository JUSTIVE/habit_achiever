enum RoutineEnum{Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday}

class Routine{
  Routine(){
    this._routines =List<bool>();
    
    for(int i=0;i<RoutineEnum.values.length;i++){
      routines.add(true);
    }
  }

  List<bool> _routines; 
  Routine.fromJson(List<dynamic> json)
  :_routines=json.map((x)=>(x as bool)).toList();
  

  List<bool> toJson()=>routines;


  int setValue(int index){
    _routines[index]=!_routines[index];
    bool checker=false;
    for(bool i in _routines)
      checker|=i;
    if(!checker){
      for(int i=0;i<RoutineEnum.values.length;i++)
        _routines[i]=true;
      return 1;
    }
    else return 0;
  }

  List<bool> get routines=>_routines;
}