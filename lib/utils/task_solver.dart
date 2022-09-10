import 'package:test_task/data_models/field_cell_model.dart';
import 'package:test_task/data_models/field_model.dart';
import 'package:test_task/data_models/queue_cell.dart';
import 'package:test_task/data_models/task_data.dart';

class TaskSolver {
  late FieldModel _fieldModel;
  List<QueueCell> _cellQueue = [];

  Future<FieldModel> solveTask(TaskData taskData) async {
    _cellQueue = [];
    await _createFieldModel(taskData.field, taskData.id);
    _markStartAndFinish(
      taskData.startCoordinates,
      taskData.finishCoordinates,
    );
    _findShortestPathByBFS(taskData.startCoordinates);
    return _fieldModel;
  }

  Future<void> _createFieldModel(List<String> fieldData, String id) async {
    List<List<FieldCellModel>> field = [];
    for (int i = 0; i < fieldData.length; i++) {
      field.add([]);
      for (int j = 0; j < fieldData[i].length; j++) {
        field[i].add(
          FieldCellModel(
            xCoordinate: j,
            yCoordinate: i,
            isNotVisited: true,
            cellType:
                fieldData[i][j] == 'X' ? CellType.blocked : CellType.empty,
          ),
        );
      }
    }
    _fieldModel = FieldModel(
      field: field,
      id: id,
    );
  }

  void _markStartAndFinish(
    Map<String, int> start,
    Map<String, int> finish,
  ) {
    _fieldModel.field[start['y']!][start['x']!].cellType = CellType.start;
    _fieldModel.field[finish['y']!][finish['x']!].cellType = CellType.finish;
  }

  void _findShortestPathByBFS(Map<String, int> start) async {
    _cellQueue.add(
      QueueCell(
        path: [],
        fieldCell: _fieldModel.field[start['y']!][start['x']!],
      ),
    );
    _processQueue();
  }

  void _processQueue() {
    FieldCellModel currentCell = _cellQueue.first.fieldCell;
    currentCell.isNotVisited = false;
    if (currentCell.cellType == CellType.finish) {
      _fieldModel.shortestPath = _cellQueue.first.path + [currentCell];
    } else if (_fieldModel.shortestPath.isEmpty) {
      _findNeighbours(_cellQueue.first.path + [currentCell]);
      _processQueue();
    }
  }

  void _findNeighbours(List<FieldCellModel> previousPath) {
    int x = _cellQueue.first.fieldCell.xCoordinate;
    int y = _cellQueue.first.fieldCell.yCoordinate;
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        int nextX = x + i;
        int nextY = y + j;
        if (_isInbounds(nextX, nextY)) {
          FieldCellModel nextCell = _fieldModel.field[nextY][nextX];
          if (nextCell.isNotVisited && nextCell.cellType != CellType.blocked) {
            _cellQueue.add(
              QueueCell(
                path: previousPath,
                fieldCell: nextCell,
              ),
            );
          }
        }
      }
    }
    _cellQueue.removeAt(0);
  }

  bool _isInbounds(int nextX, int nextY) {
    return nextX >= 0 &&
        nextX < _fieldModel.field[0].length &&
        nextY >= 0 &&
        nextY < _fieldModel.field.length;
  }
}
