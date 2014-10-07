var get = Ember.get;
Resistance.NominationSerializer = DS.RESTSerializer.extend({
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
    if ( relationship.key == 'players' ) {
      json['player_ids'] = record.get('players').mapBy('id');
    }
  }
});
