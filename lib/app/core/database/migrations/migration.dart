abstract class Migration {
  void create(batch);
  void update(batch);
  void downgrade(batch);
}
