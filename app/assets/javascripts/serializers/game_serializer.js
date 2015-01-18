Resistance.GameSerializer = DS.RESTSerializer.extend({
  keyForRelationship: function (key, relationship) {
    if ( relationship == 'hasMany' ) {
      return key.singularize() + '_ids';
    } else if ( relationship == 'belongsTo' ) {
      return key + '_id';
    } else {
      return key;
    }
  },
  serializeHasMany: function(record, json, relationship) {
    if ( relationship.key == 'users' ) {
      json['user_ids'] = record.get('users').mapBy('id');
    }
  }
});
