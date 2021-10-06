class GridViewModel {
  String id;
  List gridItems;
  String? description;
  String? author;
  //DateTime created;
  //DateTime lastModified;

  GridViewModel({
    required this.id,
    required this.gridItems,
  });
  //factory GridViewModel.fromJson({});

}

class GridItemModel {
  String type;
  GridItemQueryModel query;
  Map params;

  GridItemModel({
    required this.type,
    required this.query,
    required this.params,
  });
}

class GridItemQueryModel {
  String testQuery;
  GridItemQueryModel({
    required this.testQuery,
  });
}

class GridItemParametersModel {
  String testField;
  GridItemParametersModel({
    required this.testField,
  });
}
