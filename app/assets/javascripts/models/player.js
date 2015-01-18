Resistance.Player = DS.Model.extend({
  game: DS.belongsTo('game'),
  user: DS.belongsTo('user'),
  team: DS.attr('string'),
  name: DS.attr('string'),

  nominated: function () {
    var mission = this.get('game').get('currentMission');
    if (!mission) {
      return false;
    }
    var nom = mission.get('currentNomination');
    return nom && nom.get('players')
      .contains(this);
  }.property('game.currentMission.currentNomination.players.@each'),

  isKing: function () {
    return this.get('game').get('king').get('id') == this.get('id');
  }.property('game.king'),

  vote: function () {
    var votes = this.get('game.currentMission.currentNomination.votes');
    if (votes) {
      return votes.findBy('player', this);
    }
  }.property('game.currentMission.currentNomination.votes.@each.player'),

  hasVoted: function () {
    return this.get('vote') != undefined;
  }.property('vote'),

  isElected: function () {
    var nom = this.get('game.currentMission.currentNomination');
    return nom && nom.get('players').contains(this);
  }.property('game.currentMission.currentNomination.passed'),

  shallGoOnMission: function () {
    return this.get('isElected') &&
      !this.get('game.currentMission.missionResults').anyBy('player', this);
  }.property('isElected', 'game.currentMission.missionResults.@each.player'),

  isResistance: function () {
    return this.get('team') == 'resistance';
  }.property('team'),

  isSpy: function () {
    return this.get('team') == 'spies';
  }.property('team'),

});
