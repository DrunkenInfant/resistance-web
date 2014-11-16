Resistance.Nomination = DS.Model.extend({
  mission: DS.belongsTo('mission'),
  players: DS.hasMany('player'),
  votes: DS.hasMany('vote'),

  passed: function () {
    return this.get('votes').filterBy('pass').length >
      this.get('mission.game.players.length') / 2;
  }.property('votes.@each.pass'),

  voteOngoing: function () {
    return this.get('votes.length') !=
      this.get('mission.game.players.length');
  }.property('votes.@each'),

  incorrectNbrNominatedPlayers: function () {
    return this.get('players.length') !=
      this.get('mission.nbr_participants');
  }.property('players.@each'),
});
