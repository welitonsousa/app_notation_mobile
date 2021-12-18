// ignore_for_file: unused_element

enum ModelState { stope, error, success, loading }

extension on ModelState {
  String toShortString() {
    return toString().split('.').last;
  }
}
