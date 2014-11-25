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
  }.property('players.length'),

  playersNotVoted: function () {
    var playersVoted = this.get('votes').map(function (v) { return v.get('player'); });
    return this.get('mission.game.players').filter(function (p) {
      return !playersVoted.contains(p);
    });
  }.property('votes.@each'),

  index: function () {
    return this.get('mission.nominations').indexOf(this) + 1;
  }.property('index'),

  isFirst: function () {
    return this.get('index') == 1;
  }.property('index'),

  isSecond: function () {
    return this.get('index') == 2;
  }.property('index'),

  isThird: function () {
    return this.get('index') == 3;
  }.property('index'),

  isFourth: function () {
    return this.get('index') == 4;
  }.property('index'),

  isFifth: function () {
    return this.get('index') == 5;
  }.property('index'),
});
