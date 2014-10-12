Resistance.Player = DS.Model.extend({
  game: DS.belongsTo('game'),
  user_id: DS.attr(),
  team: DS.attr('string'),

  nominated: function () {
    return this.get('game').get('currentMission').get('currentNomination').get('players').contains(this)
  }.property('game.currentMission.currentNomination.players.@each')
});
