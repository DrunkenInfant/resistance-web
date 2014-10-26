Resistance.Player = DS.Model.extend({
  game: DS.belongsTo('game'),
  user: DS.belongsTo('user'),
  team: DS.attr('string'),

  nominated: function () {
    return this.get('game')
      .get('currentMission')
      .get('currentNomination')
      .get('players')
      .contains(this);
  }.property('game.currentMission.currentNomination.players.@each'),

  isKing: function () {
    return this.get('game').get('king').get('id') == this.get('id');
  }.property('game.king'),

  vote: function () {
    return this.get('game.currentMission.currentNomination.votes')
      .findBy('player', this);
  }.property('game.currentMission.currentNomination.votes.@each.player'),

  hasVoted: function () {
    return this.get('vote') != undefined;
  }.property('vote'),
});
