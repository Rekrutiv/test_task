class FieldCellModel {
  final int xCoordinate;
  final int yCoordinate;
  bool isNotVisited;
  CellType cellType;

  FieldCellModel({
    required this.xCoordinate,
    required this.yCoordinate,
    required this.isNotVisited,
    required this.cellType,
  });
}

enum CellType {
  start,
  finish,
  empty,
  blocked,
  path,
}
