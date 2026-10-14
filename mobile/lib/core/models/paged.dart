/// Respons daftar berpaginasi Laravel: `{ data, links, meta }`.
class Paged<T> {
  const Paged({required this.items, required this.currentPage, required this.lastPage, required this.total});

  factory Paged.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromItem) {
    final meta = json['meta'] as Map<String, dynamic>;
    return Paged(
      items: (json['data'] as List).map((e) => fromItem(e as Map<String, dynamic>)).toList(),
      currentPage: meta['current_page'] as int,
      lastPage: meta['last_page'] as int,
      total: meta['total'] as int,
    );
  }

  final List<T> items;
  final int currentPage;
  final int lastPage;
  final int total;

  bool get hasMore => currentPage < lastPage;
}
