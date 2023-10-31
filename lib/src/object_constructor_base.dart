/// ObjectConstructor
class ObjectConstructor<Key, ConstructedObject,
    T extends UnderConstructingObject<ConstructedObject>> {
  final Map<Key, T> _underConstructingObjects = {};

  ConstructedObject? constructing({
    required Key key,
    required T Function(T? underConstructedObject) builder,
  }) {
    final underConstructionObject = _underConstructingObjects[key];
    final isNewObject = underConstructionObject == null;
    final T changedUnderConstructionObject;
    if (isNewObject) {
      changedUnderConstructionObject = builder(null);
      _underConstructingObjects[key] = changedUnderConstructionObject;
    } else {
      changedUnderConstructionObject = builder(underConstructionObject);
      _underConstructingObjects[key] = changedUnderConstructionObject;
    }
    if (changedUnderConstructionObject.isConstructed) {
      _underConstructingObjects.remove(key);
      return changedUnderConstructionObject.construct();
    }
    return null;
  }
}

abstract interface class UnderConstructingObject<ConstructedObject> {
  bool get isConstructed;
  ConstructedObject construct();
}
