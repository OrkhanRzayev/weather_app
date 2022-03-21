class Weather {
  final String description;
  final double temprature;
  final double windSpeed;
  final int humidity;

  Weather({
    required this.description,
    required this.temprature,
    required this.windSpeed,
    required this.humidity,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['weather'][0]['description'],
      temprature: json['main']['temp'],
      windSpeed: json['wind']['speed'],
      humidity: json['main']['humidity'],
    );
  }
}
