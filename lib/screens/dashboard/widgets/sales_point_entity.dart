/// One point on the sales trend line chart, e.g. ("Thu", 22800).
/// Kept dumb on purpose — no formatting logic here, that belongs in the UI layer.
class SalesPointEntity {
  final String label; // "Mon", "Tue", ... or "Week 1", or a date
  final double value; // raw sales amount in Rs

  const SalesPointEntity({required this.label, required this.value});
}
