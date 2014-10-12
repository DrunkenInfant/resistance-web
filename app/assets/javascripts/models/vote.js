Resistance.Vote = DS.Model.extend({
  nomination: DS.belongsTo('nomination'),
  player: DS.belongsTo('player'),
  pass: DS.attr(),
});
