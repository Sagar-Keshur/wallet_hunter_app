enum Status { initial, loading, loaded, error, finished }

extension StatusExtension on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isLoaded => this == Status.loaded;
  bool get isError => this == Status.error;
  bool get isFinished => this == Status.finished;
}
