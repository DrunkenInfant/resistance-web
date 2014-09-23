Resistance.Mission = DS.Model.extend({
  game: DS.belongsTo('game'),
  nbr_participants: DS.attr(),
  nbr_fails_required: DS.attr()
});
