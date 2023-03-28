abstract class WeatherStates {}

class WeatherInitial extends WeatherStates {}

class WeatherGetApiSuccessState extends WeatherStates {}

class WeatherGetApiErrorState extends WeatherStates {}

class WeatherGetApiLoadingState extends WeatherStates {}

class WeatherConvertToJsonState extends WeatherStates {}
class getCityNameSuccessfully extends WeatherStates {}
