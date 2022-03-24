class Daily {
  final int dataTime;
  final double temprature;
  final double windSpeed;
  final int humidity;
  final String description;

  Daily({
    required this.dataTime,
    required this.temprature,
    required this.windSpeed,
    required this.humidity,
    required this.description,
  });

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
        description: json['weather'][0]['description'],
        dataTime: json['dt'],
        temprature: json['temp']['day'],
        windSpeed: json['wind_speed'],
        humidity: json['humidity']);
  }
}
