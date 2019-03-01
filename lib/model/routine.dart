enum RoutineEnum{Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday}

class Routine{
  Routine(){
    this._routines =List<bool>();
    
    for(int i=0;i<RoutineEnum.values.length;i++){
      routines.add(true);
    }
  }

  List<bool> _routines; 
  Routine.fromJson(Map<String,dynamic> json)
  :_routines=List<bool>()
  ..add(json['mon'])
  ..add(json['tue'])
  ..add(json['wed'])
  ..add(json['thu'])
  ..add(json['fri'])
  ..add(json['sat'])
  ..add(json['sun']);

  Map<String, dynamic> toJson()=>{
    'mon':_routines[0],
    'tue':_routines[1],
    'wed':_routines[2],
    'thu':_routines[3],
    'fri':_routines[4],
    'sat':_routines[5],
    'sun':_routines[6],
  };


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