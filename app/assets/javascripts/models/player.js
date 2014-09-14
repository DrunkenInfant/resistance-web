Resistance.Player = DS.Model.extend({
  game: DS.belongsTo('game'),
  user_id: DS.attr(),
  team: DS.attr('string')
});
