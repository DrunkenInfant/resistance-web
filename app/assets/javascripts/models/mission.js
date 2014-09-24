Resistance.Mission = DS.Model.extend({
  game: DS.belongsTo('game'),
  nbr_participants: DS.attr(),
  nbr_fails_required: DS.attr(),
  index: DS.attr(),
  isCurrent: function () {
    return this.get('index') == 0;
  }.property('isCurrent')
});
