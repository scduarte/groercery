part of './groercery_provider.dart';

enum Status { initial, loading, loaded, error }

class GroerceryState extends Equatable {
  final Status status;
  final List<Groercery> groerceries;

  const GroerceryState({
    this.status = Status.initial,
    this.groerceries = const [],
  });

  GroerceryState copyWith({
    Status? status,
    List<Groercery>? groerceries,
  }) {
    return GroerceryState(
      status: status ?? this.status,
      groerceries: groerceries ?? this.groerceries,
    );
  }

  @override
  List<Object?> get props => [
        status,
        groerceries,
      ];
}

extension GroerceryStateExtension on GroerceryState {
  bool get isInitial => status == Status.initial;
  bool get isLoading => status == Status.loading;
  bool get isLoaded => status == Status.loaded;
  bool get isError => status == Status.error;
}
