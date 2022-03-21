class Hourly {
  final int dataTime;
  final double temprature;
  final double windSpeed;
  final int humidity;
  final String description;

  Hourly({
    required this.dataTime,
    required this.temprature,
    required this.windSpeed,
    required this.humidity,
    required this.description,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return Hourly(
        dataTime: json['dt'],
        temprature: json['temp'],
        windSpeed: json['wind_speed'],
        humidity: json['humidity'],
        description: json['weather'][0]['description']);
  }
}
