abstract class DAO<T> {
  Future<dynamic> create(T value);
  Future<T> findOne(int id);
  Future<List<T>> findAll();
  Future<dynamic> update(T value);
  Future<dynamic> delete(int id);
}
