part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final String url;

  const SettingsState({required this.url});

  SettingsState copyWith({
    String? url,
  }) {
    return SettingsState(
      url: url ?? this.url,
    );
  }

  @override
  List<Object?> get props => [url];

  Map<String, dynamic> toMap() {
    return {
      'url': url,
    };
  }

  factory SettingsState.fromMap(Map<String, dynamic> map) {
    return SettingsState(
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsState.fromJson(String source) =>
      SettingsState.fromMap(json.decode(source));
}
