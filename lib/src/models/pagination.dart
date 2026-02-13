class Pagination {
  final int? page;
  final int? limit;
  final int? total;
  final bool? hasMore;

  Pagination({this.page, this.limit, this.total, this.hasMore});

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json['page'] as int?,
        limit: json['limit'] as int?,
        total: json['total'] as int?,
        hasMore: json['hasMore'] as bool?,
      );
}
