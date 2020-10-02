import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

abstract class ProductCategory extends Equatable {
  String name, taxonomy, description, slug;
  int term_id, term_group, parent, count, filter, term_taxonomy_id;


  ProductCategory(this.name,
      this.taxonomy,
      this.description,
      this.slug,
      this.term_id,
      this.term_group,
      this.parent,
      this.count,
      this.filter,
      this.term_taxonomy_id);

  @override
  String toString() {
    return 'ProductCategory{name: $name, taxonomy: $taxonomy, description: $description, slug: $slug, term_id: $term_id, term_group: $term_group, parent: $parent, count: $count, filter: $filter, term_taxonomy_id: $term_taxonomy_id}';
  }
}
