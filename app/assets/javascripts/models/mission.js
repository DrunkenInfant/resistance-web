Resistance.Mission = DS.Model.extend({
  game: DS.belongsTo('game'),
  nbr_participants: DS.attr(),
  nbr_fails_required: DS.attr(),
  index: DS.attr(),
  nominations: DS.hasMany('nomination'),

  isCurrent: function () {
    return this.get('index') == 0;
  }.property('isCurrent'),

  newNomination: function () {
    var nom =  this.store.createRecord('nomination', {
      mission: this
    });
    this.notifyPropertyChange('nominations');
    return nom;
  }.property(),

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
    if (!curNom || curNom.get('isNew') ||
        curNom.get('votes').get('length') ==
        this.get('game').get('players').length) {
      return 'nominate';
    } else {
      return 'vote';
    }
  }.property('currentNomination.isNew')
});
