Resistance.Mission = DS.Model.extend({
  game: DS.belongsTo('game'),
  nbr_participants: DS.attr(),
  nbr_fails_required: DS.attr(),
  index: DS.attr(),
  nominations: DS.hasMany('nomination'),
  missionResults: DS.hasMany('missionResult'),

  isCurrent: function () {
    return this.get('game.currentMission') == this;
  }.property('game.currentMission'),

  isCompleted: function () {
    return this.get('missionResults.length') == this.get('nbr_participants');
  }.property('missionResults.length'),

  isNotCompleted: function () {
    return !this.get('isCompleted');
  }.property('isCompleted'),

  hasSucceded: function () {
    return this.get('isCompleted') &&
      this.get('missionResults').filterBy('success', false).get('length') <
        this.get('nbr_fails_required');
  }.property('isCompleted'),

  hasFailed: function () {
    return this.get('isCompleted') &&
      this.get('missionResults').filterBy('success', false).get('length') >=
        this.get('nbr_fails_required');
  }.property('isCompleted'),

  newNomination: function () {
    var nom = this.get('currentNomination');
    if (!nom || !nom.get('isNew')) {
      var nom =  this.store.createRecord('nomination', {
        mission: this
      });
    }
    return nom;
  },

  currentNomination: function () {
    var noms = this.get('nominations');
    var lastNom = null;
    if (noms.get('length') > 0) {
      lastNom = noms.objectAt(noms.get('length') - 1);
    }
    return lastNom;
  }.property('nominations.@each.isNew'),

  state: function () {
    var curNom = this.get('currentNomination');
    if (curNom && curNom.get('passed')) {
      return 'mission';
    } else if (curNom && !curNom.get('isNew') && curNom.get('voteOngoing')) {
      return 'vote';
    } else {
      return 'nominate';
    }
  }.property('currentNomination.isNew', 'currentNomination.passed', 'currentNomination.voteOngoing')
});
