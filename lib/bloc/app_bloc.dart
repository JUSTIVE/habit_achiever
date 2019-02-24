import 'main_page_bloc.dart';
import 'main_page_progress_bloc.dart';

class AppBloc {
  MainPageBloc _mainPageBloc;
  MainPageProgressBloc _mainPageProgressBloc;

  AppBloc(){
    _mainPageBloc = MainPageBloc();
    _mainPageProgressBloc = MainPageProgressBloc();
  }
      

  MainPageBloc get mainPageBloc => _mainPageBloc;

  MainPageProgressBloc get mainPageProgressBloc = _mainPageProgressBloc;

}
