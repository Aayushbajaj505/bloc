import 'dart:async';
import 'counter_event.dart';

class CounterBloc {
  int _counter = 0;
  final _counterStateController = StreamController<int>();
//  Stream controller has 2 holes one for one input and one for output
  StreamSink<int> get _inCounter => _counterStateController.sink;
// for state, exposing only a stream which outputs data
  Stream<int> get counter => _counterStateController.stream;

  final _counterEventCOntroller = StreamController<CounterEvent>();
  //Exposing only the sink to get inputs from CounterEvent class
  Sink<CounterEvent> get counterEventsink => _counterEventCOntroller.sink;

  CounterBloc() {
    _counterEventCOntroller.stream.listen(_mapeventostate);
  }
  void _mapeventostate(CounterEvent event) {
    if (event is IncreamentEvent) {
      _counter++;
    } else
      _counter--;

    _inCounter.add(_counter);
  }

  void dispose() {
    _counterEventCOntroller.close();
    _counterStateController.close();
  }
}
